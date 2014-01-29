/*****************************************************************************\
|*
|*  COPYRIGHT:     Copyright (c) 2008, Altium
|*
|*  DESCRIPTION:   ICS307 Clock generator device driver
|*
\*****************************************************************************/

#include <stdlib.h>
#include <string.h>

#include <drv_spi.h>
#include <drv_ics307.h>
#include <drv_ics307_cfg_instance.h>
#if ( __POSIX_KERNEL__ != 0 )
#include <pthread.h>
#endif


struct _ics307_t
{
    spi_t                   *spi;
    unsigned int            last_writen_value;
    uint8_t                 device_id;
#if ( __POSIX_KERNEL__ != 0 )
    pthread_mutex_t         mutex;
#endif
};


static ics307_t ics307_table[DRV_ICS307_INSTANCE_COUNT];

//..............................................................................

/**
 * @brief programs the ICS307 to generate a new output frequency
 *
 * Output Frequency for CLK1 = Fref * 2 * (VDW + 8) / ((RDW + 2) * OD)
 *
 * @param       drv     ics307 driver pointer
 * @param       config  Configuration word :
 *
 *         MSB                                 LSB
 *        +----+----+-----+----+----+----+----+----+
 *        | C1   C0 | TTL | F1   F0 | S2   S1   S0 |
 *        +----+----+--+--+--+-+-+--+-+--+----+--+-+
 *           |   |     |     |   |    |          |
 *           +-+-+     |     +-+-+    +-----+----+
 *             |       |       |            |
 *        Crystal    Output  CLK2      Output Divide
 *        Load       Duty    Output
 *        Impedance  Cycle   Select
 * @param       vdw     VCO Divider Word  (9 significant bits)
 * @param       rdw     Reference Divider Word  (7 significant bits)
 *
 * @return  -1 in case of error, 0 other wise
 */
int
drv_ics307_program(ics307_t *drv, unsigned char config, unsigned int vdw, unsigned char rdw)
{
    if (drv != NULL)
    {
        return drv_ics307_program_word(drv, (((unsigned int)config) << 16) | ((vdw & 0x1ff) << 7) | (rdw & 0x7f));
    }
    return -1;
}

/**
 * @brief programs command word 'data' into the clock generator chip.
 *
 * @param       drv     ics307 driver pointer
 * @param       data    value to progrmam the ics309 with.
 *
 * @return  -1 in case of error, 0 other wise
 */
int
drv_ics307_program_word(ics307_t *drv, unsigned int data)
{
    int ret = -1;
    if (drv != NULL)
    {
#if ( __POSIX_KERNEL__ != 0 )
        pthread_mutex_lock(&drv->mutex);
#endif

        if (spi_get_bus(drv->spi, drv->device_id))
        {
            spi_cs_lo(drv->spi);
            spi_set_endianess(drv->spi, true);
            spi_transmit32(drv->spi, data);
            while (spi_busy(drv->spi));     // wait until all bits are send
            spi_cs_hi(drv->spi);
            spi_release_bus(drv->spi);
            drv->last_writen_value = data;
            ret = 0;
        }

#if ( __POSIX_KERNEL__ != 0 )
        pthread_mutex_unlock(&drv->mutex);
#endif
    }
    return ret;
}


/**
 * @brief returns the last writen/programmed value.
 *
 * Returns the last writen/programmed value. This is the value saved the last time the ICS309 was programmed, it is not possible to read the value for the ICS307 IC.
 *
 * @param       drv     ics307 driver pointer
 * @param       data    pointer to address where to store last written value
 *
 * @return  0 when last value is store at data location, -1 in case of error/no last value
 */
int
drv_ics307_read_word(ics307_t *drv, unsigned int *data)
{
    int ret = -1;

    if (drv != NULL)
    {
#if ( __POSIX_KERNEL__ != 0 )
        pthread_mutex_lock(&drv->mutex);
#endif
        if (drv->last_writen_value != -1)
        {
            *data = drv->last_writen_value;
            ret = 0;
        }
#if ( __POSIX_KERNEL__ != 0 )
        pthread_mutex_unlock(&drv->mutex);
#endif
    }
    return ret;
}

/**
 * @brief Open an instance of the driver
 *
 * This function initializes the internal driver data sturcture.
 *
 * @param      id    valid driver id
 *
 * @return Driver pointer if succesful initialization, NULL otherwise.
 */
ics307_t *
drv_ics307_open(int id)
{
    if (id >= 0 && id < DRV_ICS307_INSTANCE_COUNT)
    {
        if (ics307_table[id].spi == NULL)
        {
            ics307_table[id].spi = spi_open(drv_ics307_instance_table[id].drv_spi);
            if (ics307_table[id].spi == NULL)
            {
                return NULL;
            }
#if ( __POSIX_KERNEL__ != 0 )
            if (pthread_mutex_init(&ics307_table[id].mutex, NULL) != 0)
            {
                // there's no -> spi_close(ics307_table[id].spi);
                ics307_table[id].spi = NULL;
                return NULL;
            }
#endif
            ics307_table[id].last_writen_value = -1;
            ics307_table[id].device_id = drv_ics307_instance_table[id].device_id;
        }
        return &ics307_table[id];
    }
    return NULL;
}

#define CLK             ((unsigned int)20000000)
#define CLK2            ((unsigned int)10000000)
#define CLK4            ((unsigned int)5000000)

/**
 * @brief determine the best match paramters for the ics307 for the specified frequency
 *
 * @param       freq    frequency in Hz
 * @param       pod     pointer to address where to store calculted "Output Divider"
 * @param       pvdw    pointer to address where to store calculted "VCO Divider Word"
 * @param       prdw    pointer to address where to store calculted "Reference Divider Word"
 *
 * @return  -1 in case of no match, 0 in case of closest/best match, 1 in case of exact match
 */
int
drv_ics307_best_match(unsigned int freq, unsigned int *pod, unsigned int *pvdw, unsigned int *prdw)
{
    unsigned int i, od, vdw, rdw, tmp, clk1;
    unsigned int best_match = 0, prev_calc = 0;
    unsigned int bm_od = 0, bm_vdw = 0, bm_rdw = 0;
#if 1
/* Table 1. Output Divide and Maximum Output Frequency */
    int freq_max[] = { 40000000,
                       50000000,
                       55000000,
                       67000000,
                       80000000,
                       100000000,
                       135000000,
                       200000000,
                       0 };
#else
/* industrial */
    int freq_max[] = { 36000000,
                       45000000,
                       50000000,
                       60000000,
                       72000000,
                       90000000,
                       120000000,
                       180000000,
                       0 };
#endif
    int clk1_divide[] = { 10, 8, 7, 6, 5, 4, 3, 2, 0 };
    int mapping[]     = { -1, -1, 1, 6, 3, 4, 7, 5, 2, -1, 0 };


    for (i = 0; freq_max[i] < freq && freq_max[i] != 0; i++);

    for (od = clk1_divide[i]; od != 0; od = clk1_divide[++i])
    {
        for (vdw = 4; vdw <= 511; vdw++)
        {
            for (rdw = 1; rdw <= 127; rdw++)
            {
                if (200000 >= (CLK / rdw + 2))
                {
                    /* check
                     * 200kHz < Input Frequency / (RDW + 2)
                     */
                    continue;
                }
                if (vdw < 100)
                {
                    tmp = CLK * 2 * (vdw + 8U) / (rdw + 2U);
                    if (60000000 > tmp || 360000000 < tmp)
                    {
                        continue;
                    }
                    clk1 = CLK * 2 * (vdw + 8) / ((rdw + 2) * od);
                }
                else if (vdw < 421)
                {
                    if (rdw < 2)
                    {
                        continue;
                    }
                    tmp = 4 * (CLK2 * (vdw + 8) / (rdw + 2));
                    if (60000000 > tmp || 360000000 > tmp)
                    {
                        continue;
                    }
                    clk1 = 4 * (CLK2 * (vdw + 8) / ((rdw + 2) * od));
                }
                else
                {
                    if (rdw < 6)
                    {
                        continue;
                    }
                    tmp = 8 * (CLK4 * (vdw + 8) / (rdw + 2));
                    if (60000000 > tmp || 360000000 < tmp)
                    {
                        continue;
                    }
                    clk1 = 8 * (CLK4 * (vdw + 8) / ((rdw + 2) * od));
                }
                if (clk1 == freq)
                {
                    *pod = mapping[od];
                    *pvdw = vdw;
                    *prdw = rdw;
                    return 1;
                }
                else if (abs(freq - clk1) < abs(freq - best_match))
                {
                    bm_od = mapping[od];
                    bm_vdw = vdw;
                    bm_rdw = rdw;
                    best_match = clk1;
                }
            }
        }
    }
    if (best_match != 0)
    {
        *pod = bm_od;
        *pvdw = bm_vdw;
        *prdw = bm_rdw;
        return 0;
    }

    return -1;
}

/**
 * @brief program the ics307 for the specified frequency in MHz
 *
 * @param       drv         ics307 driver pointer
 * @param       freq        frequency in MHz
 *
 * @return 0 if succes, -1 in case of error
 */
int
drv_ics307_program_freq_mhz(ics307_t *drv, int freq)
{
    unsigned int od, vdw, rdw;
    int ret = -1;

    if (drv != NULL)
    {
        ret = drv_ics307_best_match(freq * 1000 * 1000, &od, &vdw, &rdw);
        if (ret >= 0)
        {
            ret = drv_ics307_program(drv, (unsigned char)od, vdw, (unsigned char)rdw);
        }
    }
    return ret;
}

