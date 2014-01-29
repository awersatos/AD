////////////////////////////////////////////////////////////////////////////////
// HardwareDebug.c

#if HARDWARE_DEBUG

#include <drv_ioport.h>

#define TEST_STATE_PORT     0

////////////////////////////////////////////////////////////////////////////////
ioport_t *testPort_g;

////////////////////////////////////////////////////////////////////////////////
void HDBG_Init(uint32_t testPort)
{
    testPort_g = ioport_open(testPort);
    ioport_set_value(testPort_g, TEST_STATE_PORT, 0);
}

////////////////////////////////////////////////////////////////////////////////
void HDBG_SetLeds(uint32_t value)
{
    uint32_t tmp;

    tmp = ioport_get_value(testPort_g, TEST_STATE_PORT);
    tmp |= value;

    ioport_set_value(testPort_g, TEST_STATE_PORT, tmp);
}

////////////////////////////////////////////////////////////////////////////////
void HDBG_ClrLeds(uint32_t value)
{
    uint32_t tmp;

    tmp = ioport_get_value(testPort_g, TEST_STATE_PORT);

    tmp &= ~value;

    ioport_set_value(testPort_g, TEST_STATE_PORT, tmp);
}
#endif











