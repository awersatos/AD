/**
 * @file
 *
 * @brief
 *      driver for NB1 keypad peripheral
 */

#ifndef _DRV_KEYPAD_H
#define _DRV_KEYPAD_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdbool.h>

typedef struct _drv_keypad_t drv_keypad_t;

drv_keypad_t    *keypad_open                        ( int id );
unsigned char   *keypad_get_ascii_lookup_table      ( drv_keypad_t *drv );
void            keypad_set_ascii_lookup_table       ( drv_keypad_t *drv, unsigned char * table );

bool            keypad_get_enable_repeat            ( drv_keypad_t *drv );
void            keypad_set_enable_repeat            ( drv_keypad_t *drv, bool enabled );

unsigned int    keypad_get_initial_repeat_delay_ms  ( drv_keypad_t *drv );
void            keypad_set_initial_repeat_delay_ms  ( drv_keypad_t *drv, unsigned int ms );
unsigned int    keypad_get_repeat_delay_ms          ( drv_keypad_t *drv );
void            keypad_set_repeat_delay_ms          ( drv_keypad_t *drv, unsigned int ms );

void            keypad_reset                        ( drv_keypad_t *drv );
unsigned char   keypad_get_current_key              ( drv_keypad_t *drv );
int             keypad_is_key_down                  ( drv_keypad_t *drv );

unsigned char   keypad_get_next_key                 ( drv_keypad_t *drv );
int             keypad_read                         ( drv_keypad_t *drv, char * buf, size_t size );

#ifdef  __cplusplus
}
#endif

#endif /* ndef _DRV_KEYPAD_H */

