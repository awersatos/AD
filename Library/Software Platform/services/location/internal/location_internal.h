/*************************************************************************
|*
|*  VERSION CONTROL:    $Version$   $Date$
|*
|*  IN PACKAGE:
|*
|*  COPYRIGHT:          Copyright (c) 2010, Altium
|*
|*  DESCRIPTION:
|*
 */

#ifndef __LOCATION_INTERNAL_H__
#define __LOCATION_INTERNAL_H__

#include <stdint.h>
#include "location.h"

typedef void             * location_open_fn    (unsigned int id);
typedef bool               location_start_fn   (void * instance);
typedef bool               location_stop_fn    (void * instance);
typedef bool               location_get_info_fn(void * instance, location_info_t * info);

location_t * location_init(unsigned int location_id,
                           unsigned int adaptor_id,
                           location_open_fn     * open_fn,
                           location_start_fn    * start_fn,
                           location_stop_fn     * stop_fn,
                           location_get_info_fn * get_info_fn);

#endif //  __LOCATION_INTERNAL_H__
