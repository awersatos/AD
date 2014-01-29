/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2008, Altium
|*
|*  Description:        Touchscreen service designed to run on top of AD7843-driver
|*
\*****************************************************************************/

/**
 * @file
 * Service on top of SPI based AD7843 touchscreen driver.
 * This service contains calibrating and rotating routines.
 *
 */

#include <assert.h>
#include <time.h>

#include <pal.h>
#include <drv_ad7843.h>
#include <touchscreen.h>
#include <touchscreen_cfg_instance.h>

/*
 * mutex support
 */

#if TOUCHSCREEN_USE_MUTEX
# define TOUCHSCREEN_MUTEX_PREPARE()                   POSIX_DEV_MUTEX_PREPARE(touchscreen_mutex_buffer)
# define TOUCHSCREEN_MUTEX_LOCK( touchscreen )        POSIX_DEV_MUTEX_LOCK(&touchscreen->mutex, touchscreen_mutex_buffer)
# define TOUCHSCREEN_MUTEX_UNLOCK( touchscreen )      POSIX_DEV_MUTEX_UNLOCK(&touchscreen->mutex, touchscreen_mutex_buffer)
#else
# define TOUCHSCREEN_MUTEX_PREPARE()            
# define TOUCHSCREEN_MUTEX_LOCK( touchscreen )          
# define TOUCHSCREEN_MUTEX_UNLOCK( touchscreen )        
#endif

#define DELAY   (clock() + PAL_CLOCKHZ / 5)
/*
 * driver data
 */

struct touchscreen_s
{
    ad7843_t                   *ad7843;          // AD7843 device driver pointer
    touchscreen_calibration_t  cal_data;
    int                        rotation;
#if TOUCHSCREEN_INSTANCE_RUNTIME_CALIBRATION_TRUE_USED != 0
    touchscreen_callback_t     callback;
    void                       *param;
    int                        calibration_state;
    int                        cal_x[3];
    int                        cal_y[3];
    clock_t                    delay;
    uint32_t                   cal_fg_color;
    uint32_t                   cal_bg_color;
#endif
#if TOUCHSCREEN_USE_MUTEX
    pthread_mutex_t            mutex;
#endif
};



// runtime driver table
static touchscreen_t drv_table[TOUCHSCREEN_INSTANCE_COUNT];

/**
 * @brief    Open an instance of the service
 *
 * This function initializes the service and opens the drivers beneath first time the service is called.
 * Further attemps to open an already opened instance of the service simply returns the same pointer.
 *
 * @param  id  valid driver id
 *
 * @return Service pointer if succesful initialized, NULL otherwise (for example: if the SPI bus could not be opened)
 */

touchscreen_t * touchscreen_open( unsigned int id )
{
    assert( id < TOUCHSCREEN_INSTANCE_COUNT );

    // Copy peripheral data to driver table
    touchscreen_t * restrict srv = &drv_table[id];
    if (!srv->ad7843)
    {
        const touchscreen_cfg_instance_t * restrict srv_cfg = &touchscreen_instance_table[id];

#if TOUCHSCREEN_USE_MUTEX
        pthread_mutexattr_t mutexattr;
        pthread_mutexattr_init( &mutexattr );
        pthread_mutex_init( &drv->mutex, &mutexattr );
#endif

        TOUCHSCREEN_MUTEX_PREPARE();
        TOUCHSCREEN_MUTEX_LOCK( srv );

        assert( srv_cfg->drv_ad7843 != -1);
        srv->ad7843 = ad7843_open( srv_cfg->drv_ad7843 );

        srv->cal_data.xfs        = srv_cfg->x_size - 1;
        srv->cal_data.yfs        = srv_cfg->y_size - 1;
        srv->cal_data.x0_offset  = srv_cfg->x0_offset;
        srv->cal_data.xfs_offset = srv_cfg->xfs_offset;
        srv->cal_data.y0_offset  = srv_cfg->y0_offset;
        srv->cal_data.yfs_offset = srv_cfg->yfs_offset;
        srv->rotation            = srv_cfg->rotation;

        TOUCHSCREEN_MUTEX_UNLOCK( srv );
    }
    return srv->ad7843 ? srv : NULL;
}


/**
 * @brief    Get raw data form touchscreen
 *
 * This function returns the raw touchscreen data.
 *
 * @param  srv    Service pointer as returned from touchscreen_open()
 * @param  raw    Pointer to user data object where data is to be returned
 *
 * @return True if result is valid, false otherwise
 */

bool touchscreen_get_raw(touchscreen_t const *srv, touchscreen_data_t *raw)
{
    bool result = false;

    TOUCHSCREEN_MUTEX_PREPARE();
    TOUCHSCREEN_MUTEX_LOCK( rrv );

    if (ad7843_get_raw(srv->ad7843, (ad7843_raw_t *)raw) == 0)
    {
        result = true;
    }
    
    TOUCHSCREEN_MUTEX_UNLOCK( srv );
    return result;
}


/**
 * @brief    Get position from touchscreen
 *
 * This function returns the calibrated touchscreen data.
 *
 * @param  srv    Service pointer as returned from touchscreen_open()
 * @param  pos    Pointer to user data object where data is to be returned
 *
 * @return True if result is valid, false otherwise
 */

bool touchscreen_get_pos(touchscreen_t const *srv, touchscreen_data_t *pos)
{
    bool result = false;
    int x, y;
    if (ad7843_get_raw(srv->ad7843, (ad7843_raw_t *)pos) == 0)
    {
        result = true;

        if (pos->pendown)
        {
            x = (pos->x - srv->cal_data.x0_offset) * srv->cal_data.xfs / (srv->cal_data.xfs_offset - srv->cal_data.x0_offset);
            if (x < 0) { x = 0;}
            if (x > srv->cal_data.xfs) { x = srv->cal_data.xfs;}

            y = (pos->y - srv->cal_data.y0_offset) * srv->cal_data.yfs / (srv->cal_data.yfs_offset - srv->cal_data.y0_offset);
            if (y < 0) { y = 0;}
            if (y > srv->cal_data.yfs) { y = srv->cal_data.yfs;}

            switch (srv->rotation)
            {
            case TOUCHSCREEN_ROTATION_0:
                pos->x = x;
                pos->y = y;
                break;
            case TOUCHSCREEN_ROTATION_90:
                pos->x = y;
                pos->y = srv->cal_data.xfs - x;
                break;
            case TOUCHSCREEN_ROTATION_180:
                pos->x = srv->cal_data.xfs - x;
                pos->y = srv->cal_data.yfs - y;
                break;
            case TOUCHSCREEN_ROTATION_270:
                pos->x = srv->cal_data.yfs - y;
                pos->y = x;
                break;
            }
        }
    }

    return result;
}


/**
 * @brief    Set touchscreen rotation
 *
 * This function sets the rotation of the touchscreen.
 *
 * @param  srv       Service pointer as returned from touchscreen_open()
 * @param  rotation  Rotation in multiples of 90 degrees
 *
 * @return Nothing
 */

void touchscreen_set_rotation(touchscreen_t * srv, int rotation)
{
    int r = (rotation / 90 ) % 4;
    if (r < 0) r += 4;

    srv->rotation = r * 90;
}


/**
 * @brief    Get touchscreen rotation
 *
 * This function returns the rotation of the touchscreen.
 *
 * @param  srv    Service pointer as returned from touchscreen_open()
 *
 * @return Current rotation
 */

int touchscreen_get_rotation(touchscreen_t const * srv)
{
    return srv->rotation;
}


/**
 * @brief    Get pointer to calibration data
 *
 * This function returns a pointer to the calibration data of the touchscreen.
 *
 * @param  srv    Service pointer as returned from touchscreen_open()
 *
 * @return Pointer to calibration data
 */

const touchscreen_calibration_t *touchscreen_get_calibration_data_pointer(touchscreen_t const * srv)
{
    return &srv->cal_data;
}


/**
 * @brief    Get calibration data
 *
 * This function stores the calibration data of the touchscreen into a provided structure.
 *
 * @param  srv    Service pointer as returned from touchscreen_open()
 * @param  calibration_data Pointer to structure which will be filled with the calibration data
 *
 * @return Nothing
 */

void touchscreen_get_calibration_data(touchscreen_t const * srv, touchscreen_calibration_t * calibration_data)
{
    *calibration_data = srv->cal_data;
}


/**
 * @brief    Set calibration data
 *
 * This function restores the calibration data of the touchscreen.
 *
 * @param  srv    Service pointer as returned from touchscreen_open()
 * @param  calibration_data Pointer to structure containing the calibration data
 *
 * @return Nothing
 */

void touchscreen_set_calibration_data(touchscreen_t * srv, touchscreen_calibration_t const * calibration_data)
{
    srv->cal_data = *calibration_data;
}


#if TOUCHSCREEN_INSTANCE_RUNTIME_CALIBRATION_TRUE_USED != 0


/**
 * @brief    Set callback function
 *
 * This sets the callback function. The callback function is called while calibration,
 * making it possible to add application specific action to the calibration routine.
 * The callback function is called each time a marker is drawn on the screen.
 *
 * @param  srv    Service pointer as returned from touchscreen_open()
 * @param  callback Callback function
 * @param  param   parameter passed on to the callback function
 *
 * @return Nothing
 */

void touchscreen_set_callback(touchscreen_t * srv, touchscreen_callback_t callback, void *param)
{
    srv->callback = callback;
    srv->param = param;
}


/**
 * @brief    Calibrate touchscreen
 *
 * Call this function repeatedly to calibrate the touchscreen.
 * The user has to touch the marked position until this function returns true, which indicates the touchscreen being calibrated.
 * Each time the marker is written on a different location the callback function is called too.
 *
 * @param  srv      Service pointer as returned from touchscreen_open()
 * @param  x_size   x size of the touchscreen
 * @param  y_size   y size of the touchscreen
 *
 * @return True if calibration is finished, false otherwise
 */

bool touchscreen_calibrate(touchscreen_t *srv, int x_size, int y_size)
{
    int result = false;
    ad7843_raw_t raw;
    int limit;
    int error;
    int average_low, average_hight;

    switch (srv->calibration_state)
    {
    case 0:
        if (srv->callback)
        {
            srv->callback(x_size/8, y_size/8, x_size, y_size, srv->param);
        }
        srv->calibration_state++;
        break;
    case 4:
        if (srv->callback)
        {
            srv->callback(x_size - x_size/8, y_size/8, x_size, y_size, srv->param);
        }
        srv->calibration_state++;
        break;
    case 8:
        if (srv->callback)
        {
            srv->callback(x_size - x_size/8, y_size - y_size/8, x_size, y_size, srv->param);
        }
        srv->calibration_state++;
        break;
    case 12:
        if (srv->callback)
        {
            srv->callback(x_size/8, y_size - y_size/8, x_size, y_size, srv->param);
        }
        srv->calibration_state++;
        break;
    case 1:
    case 5:
    case 9:
    case 13:
        if ((ad7843_get_raw(srv->ad7843, &raw) == AD7843_ERR_OK) && !raw.pendown)
        {
            srv->calibration_state++;
            srv->delay = DELAY;
        }
        break;
    case 2:
    case 6:
    case 10:
    case 14:
        if (ad7843_get_raw(srv->ad7843, &raw) == AD7843_ERR_OK)
        {
            if (raw.pendown)
            {
                if (srv->delay < clock())
                {
                    srv->calibration_state++;
                }
            }
            else
            {
                srv->delay = DELAY;
            }
        }
        break;
    case 3:
        if (ad7843_get_raw(srv->ad7843, &raw) == AD7843_ERR_OK)
        {
            if (raw.pendown)
            {
                srv->cal_x[0] = raw.x;
                srv->cal_y[0] = raw.y;
                srv->calibration_state++;
            }
            else
            {
                srv->calibration_state -= 2;
            }
        }
        break;
    case 7:
        if (ad7843_get_raw(srv->ad7843, &raw) == AD7843_ERR_OK)
        {
            if (raw.pendown)
            {
                srv->cal_x[1] = raw.x;
                srv->cal_y[1] = raw.y;
                srv->calibration_state++;
            }
            else
            {
                srv->calibration_state -= 2;
            }
        }
        break;
    case 11:
        if (ad7843_get_raw(srv->ad7843, &raw) == AD7843_ERR_OK)
        {
            if (raw.pendown)
            {
                srv->cal_x[2] = raw.x;
                srv->cal_y[2] = raw.y;
                srv->calibration_state++;
            }
            else
            {
                srv->calibration_state -= 2;
            }
        }
        break;
    case 15:
        if (ad7843_get_raw(srv->ad7843, &raw) == AD7843_ERR_OK)
        {
            if (raw.pendown)
            {
                limit = (srv->cal_x[1] + srv->cal_x[2] - raw.x - srv->cal_x[0]) / 20;
                if (limit < 0) { limit = -limit;}
                error = srv->cal_x[0] > raw.x ? srv->cal_x[0] - raw.x : raw.x - srv->cal_x[0];
                if (error > limit)
                {
                    srv->calibration_state = 0;
                    break;
                }
                error = srv->cal_x[1] > srv->cal_x[2] ? srv->cal_x[1] - srv->cal_x[2] : srv->cal_x[2] - srv->cal_x[1];
                if (error > limit)
                {
                    srv->calibration_state = 0;
                    break;
                }

                limit = (raw.y + srv->cal_y[2] - srv->cal_y[1] - srv->cal_y[0]) / 20;
                if (limit < 0) { limit = -limit;}
                error = srv->cal_y[0] > srv->cal_y[1] ? srv->cal_y[0] - srv->cal_y[1] : srv->cal_y[1] - srv->cal_y[0];
                if (error > limit)
                {
                    srv->calibration_state = 0;
                    break;
                }
                error = srv->cal_y[2] > raw.y ? srv->cal_y[2] - raw.y : raw.y - srv->cal_y[2];
                if (error > limit)
                {
                    srv->calibration_state = 0;
                    break;
                }

                /* x */
                average_low     = (srv->cal_x[0] + raw.x) / 2;
                average_hight   = (srv->cal_x[1] + srv->cal_x[2]) / 2;
                srv->cal_data.x0_offset  = average_low - (average_hight - average_low) / 6;
                srv->cal_data.xfs_offset = average_hight + (average_hight - average_low) / 6;

                /* y */
                average_low     = (srv->cal_y[0] + srv->cal_y[1]) / 2;
                average_hight   = (srv->cal_y[2] + raw.y) / 2;
                srv->cal_data.y0_offset  = average_low - (average_hight - average_low) / 6;
                srv->cal_data.yfs_offset = average_hight + (average_hight - average_low) / 6;

                switch (srv->rotation)
                {
                case TOUCHSCREEN_ROTATION_0:
                case TOUCHSCREEN_ROTATION_180:
                    srv->cal_data.xfs = x_size - 1;
                    srv->cal_data.yfs = y_size - 1;
                    break;
                case TOUCHSCREEN_ROTATION_90:
                case TOUCHSCREEN_ROTATION_270:
                    srv->cal_data.yfs = x_size - 1;
                    srv->cal_data.xfs = y_size - 1;
                    break;
                }
                srv->cal_data.xfs = x_size - 1;
                srv->cal_data.yfs = y_size - 1;
                srv->calibration_state++;
            }
            else
            {
                srv->calibration_state -= 2;
            }
        }
        break;
    case 16:
        if (srv->callback)
        {
            srv->callback(0, 0, 0, 0, srv->param);
        }
        srv->calibration_state++;
        break;
    case 17:
        if ((ad7843_get_raw(srv->ad7843, &raw) == AD7843_ERR_OK) && !raw.pendown)
        {
            srv->calibration_state = 0;
            result = true;
        }
        break;
    default:
        srv->calibration_state = 0;
        break;
    }

    return result;
}

#endif //TOUCHSCREEN_INSTANCE_RUNTIME_CALIBRATION_TRUE_USED
