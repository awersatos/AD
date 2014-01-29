
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <assert.h>

#include "location_internal.h"
#include "location_cfg_instance.h"

#define LOCATION_SIGNATURE 0x324F22A5

struct location_s {
     int                    signature;
     int                    adaptor_id;
     location_open_fn     * open_fn;
     location_start_fn    * start_fn;
     location_stop_fn     * stop_fn;
     location_get_info_fn * get_info_fn;
     void                 * context;
};

static location_t location_table[LOCATION_INSTANCE_COUNT];


/**
 * @brief    Open an instance of the service
 *
 * This function initializes the service and opens the drivers beneath first time the service is called.
 * Further attempts to open an already opened instance of the service simply return the same pointer.
 *
 * @param  id  valid service id
 *
 * @return Service pointer if succesful initialized, NULL otherwise
 */
location_t * location_open(unsigned int id)
{
    location_t * location = &location_table[id];

    assert (id < LOCATION_INSTANCE_COUNT);

    if (location->signature != LOCATION_SIGNATURE)
        return NULL;

     if (location->open_fn)
     {
         location->context = location->open_fn(location->adaptor_id);
         if (location->context)
             return location;
     }
     return NULL;
}

/**
 * @brief Activate the location service
 *
 * @param  location  a pointer to a location_t instance previously returned by location_open()
 * @return non-zero  if the device started, or
 *         0         if the device failed to start
 */
bool location_start(location_t * location)
{
    assert (location);

    if (location->signature != LOCATION_SIGNATURE)
        return false;

     if (location->start_fn)
     {
         return location->start_fn(location->context);
     }
     return false;
}

/**
 * @brief Deactivate the location service
 *
 * @param  location  a pointer to a location_t instance previously returned by location_open()
 * @return non-zero  if the device stopped, or
 *         0         if the command was unsuccessful
 */
bool location_stop(location_t * location)
{
    assert (location);

    if (location->signature != LOCATION_SIGNATURE)
        return false;

     if (location->stop_fn)
     {
         return location->stop_fn(location->context);
     }
     return false;
}

/**
 * @brief Get location information
 *
 * Get the most recent location data from the service.
 *
 * @param location    pointer to location services context previously returned by location_open()
 * @param info        pointer to info structure which will be filled with current location info
 *
 * @return true on success, false on error.
 */
bool location_get_info(location_t * location, location_info_t * info)
{
    assert (location);

    if (location->signature != LOCATION_SIGNATURE)
        return false;

     if (location->get_info_fn)
         return location->get_info_fn(location->context,info);

     return false;
}

location_t * location_init(unsigned int location_id,
                           unsigned int adaptor_id,
                           location_open_fn     * open_fn,
                           location_start_fn    * start_fn,
                           location_stop_fn     * stop_fn,
                           location_get_info_fn * get_info_fn)
{
    location_t * location = &location_table[location_id];

    assert (location_id < LOCATION_INSTANCE_COUNT);

    location->adaptor_id  = adaptor_id;
    location->open_fn     = open_fn;
    location->start_fn    = start_fn;
    location->stop_fn     = stop_fn;
    location->get_info_fn = get_info_fn;
    location->signature   = LOCATION_SIGNATURE;

    return location;
}

