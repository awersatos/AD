/******************************************************************************
|*
|*  COPYRIGHT:      Copyright 2007 Altium BV
|*
|*  DESCRIPTION:    FAT file system long file name support.
|*
\******************************************************************************/

#ifndef _FAT_LFN_H
#define _FAT_LFN_H

#include <stdint.h>

#include "fat.h"
#include "fat_layout.h"

extern int shortname2sfn( const char *name, uint8_t *sfn, int volumelabel );

extern void sfn2shortname( const uint8_t *sfn, char *name, uint8_t volumelabel );

#if FATFS_USE_LFN
extern int longname2sfn( const char *name, uint8_t *sfn );

extern void longname2lfn( const char *name, fat_direntry_lfn_t * direntry_lfn );

extern void lfn2name( fat_direntry_lfn_t * direntry_lfn, char *name, size_t size );

extern int sfn_nexttail( uint8_t *newsfn, uint8_t *sfn );

extern uint8_t sfn_checksum( const uint8_t *sfn );
#endif

#endif /* _FAT_LFN_H */
