/******************************************************************************
|*
|*  COPYRIGHT:      Copyright 2008 Altium BV
|*
|*  DESCRIPTION:    FAT file system data structures.
|*
\******************************************************************************/

#ifndef _FAT_LAYOUT_H
#define _FAT_LAYOUT_H

#include <stdint.h>

/*  FAT File System Layout
 *
 *  Boot Sector
 *  -----------
 *  File system layout information.
 *
 *  FSInfo Sector (FAT32 only)
 *  --------------------------
 *  Not used?
 *
 *  FATs
 *  ----
 *  Big array with one entry per cluster containing the next cluster number of
 *  a file or -1. FAT12 has 12 bytes per entry (3 entries for every 2 bytes),
 *  FAT16 has 16 bytes per entry and FAT32 32 bytes per entry (28 bytes used).
 *
 *  Root Sector (not for FAT32)
 *  ---------------------------
 *  Root directory entries. Fixed size.
 *
 *  Data
 *  ----
 *  Directory entries and file data.
 */

//.............................................................................
// Boot sector

// layout FAT volume sector             // bytes
typedef struct
{
    uint8_t bootstrap[3];               // 0
    char oemname[8];                    // 3
    uint8_t bytes_per_sector[2];        // 11
    uint8_t sectors_per_cluster;        // 13
    uint8_t reserved_sector_count[2];   // 14
    uint8_t number_of_fats;             // 16
    uint8_t root_entry_count[2];        // 17
    uint8_t sector_count_16[2];         // 19
    uint8_t media;                      // 21
    uint8_t sectors_per_fat_16[2];      // 22
    uint8_t sectors_per_track[2];       // 24
    uint8_t head_count[2];              // 26
    uint8_t hidden_sector_count[4];     // 28   // For FAT12 only 2 bytes
    uint8_t sector_count_32[4];         // 32   // Not for FAT12
} fat_volume_t;

// layout FAT16 specific part           // bytes
typedef struct
{
    uint8_t drive_number;               // 36
    uint8_t reserved_nt;                // 37
    uint8_t boot_signature;             // 38
    uint8_t volume_id[4];               // 39
    uint8_t volume_label[11];           // 43
    char filesystem_type[8];            // 54
} fat16_volume_t;

// layout FAT32 specific part           // bytes
typedef struct
{
    uint8_t sectors_per_fat_32[4];      // 36
    uint8_t flags[2];                   // 40
    uint8_t version[2];                 // 42
    uint8_t rootdir_cluster[4];         // 44
    uint8_t info_sector[2];             // 48
    uint8_t backup_boot_sector[2];      // 50
    uint8_t reserved[12];               // 52
    uint8_t drive_number;               // 64
    uint8_t reserved_nt;                // 65
    uint8_t boot_signature;             // 66
    uint8_t volume_id[4];               // 67
    uint8_t volume_label[11];           // 71
    char filesystem_type[8];            // 82
} fat32_volume_t;

//.............................................................................
// FSInfo (FAT32 only)

// layout FAT info sector               // bytes
typedef struct
{
    uint8_t lead_signature[4];          // 0
    uint8_t reserved1[480];             // 4
    uint8_t struct_signature[4];        // 484
    uint8_t free_cluster_count[4];      // 488
    uint8_t next_free_cluster[4];       // 492
    uint8_t reserved2[12];              // 496
    uint8_t trail_signature[4];         // 508
} fat32_fsinfo_t;

//.............................................................................
// Root sector and data

// disklayout of FAT direntry           // bytes
typedef struct
{
    uint8_t name[11];                   // 0    // 8.3
    uint8_t attributes;                 // 11
    uint8_t ntres;                      // 12
    uint8_t created_tenths;             // 13
    uint8_t created_time[2];            // 14
    uint8_t created_date[2];            // 16
    uint8_t accessed_date[2];           // 18
    uint8_t cluster_high[2];            // 20
    uint8_t modified_time[2];           // 22
    uint8_t modified_date[2];           // 24
    uint8_t cluster_low[2];             // 26
    uint8_t filesize[4];                // 28
} fat_direntry_t;

// disklayout of FAT LFN-direntry       // bytes
typedef struct
{
    uint8_t slotnumber;                 // 0
    uint8_t unicode_0[2];               // 1
    uint8_t unicode_1[2];               // 3
    uint8_t unicode_2[2];               // 5
    uint8_t unicode_3[2];               // 7
    uint8_t unicode_4[2];               // 9
    uint8_t attributes;                 // 11
    uint8_t reserved;                   // 12
    uint8_t checksum;                   // 13
    uint8_t unicode_5[2];               // 14
    uint8_t unicode_6[2];               // 16
    uint8_t unicode_7[2];               // 18
    uint8_t unicode_8[2];               // 20
    uint8_t unicode_9[2];               // 22
    uint8_t unicode_10[2];              // 24
    uint8_t dummy_cluster[2];           // 26
    uint8_t unicode_11[2];              // 28
    uint8_t unicode_12[2];              // 30
} fat_direntry_lfn_t;

#endif /* _FAT_LAYOUT_H */
