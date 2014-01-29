/*********************************************************************
 * 
 * This file describes the SPDIF channel status bits for consumer 
 * equipment as described in IEC 60958-3
 *
 *********************************************************************/

#ifndef _SPDIF_CSTAT_H
#define _SPDIF_CSTAT_H


// Bits in the SPDIF channel status word #0

#define SPDIF_CSTAT0_CONSUMER           (0x0000 << 0)       /**< Consumer mode (SPDIF) */
#define SPDIF_CSTAT0_PROFESSIONAL       (0x0001 << 0)       /**< Professional mode (AES/EBU) - do not use */
#define SPDIF_CSTAT0_PCM_AUDIO          (0x0000 << 1)       /**< Uncompressed PCM audio */
#define SPDIF_CSTAT0_COMPRESSED_AUDIO   (0x0001 << 1)       /**< Non-audio */
#define SPDIF_CSTAT0_COPY_PROHIBITED    (0x0000 << 2)       /**< SCMS enabled */
#define SPDIF_CSTAT0_COPY_PERMITTED     (0x0001 << 2)       /**< SCMS disabled */
#define SPDIF_CSTAT0_2_CHANNELS         (0x0000 << 3)       /**< 2 Channels without pre-emphasis */
#define SPDIF_CSTAT0_2_CH_PREEMPHASIS   (0x0001 << 3)       /**< 2 audio channels with 50us/15us pre-emphasis */
#define SPDIF_CSTAT0_CATMASK            (0x07F  << 8)       /**< Category mask */
#define SPDIF_CSTAT0_ORIGINAL           (0x0001 << 15)      /**< 0 for broadcast & laser optical, 1 otherwise: original data */

// Bits in the SPDIF channel status word #1

#define SPDIF_CSTAT1_SOURCEMASK         (0x000F << 0)
#define SPDIF_CSTAT1_CHANNELMASK        (0x000F << 4)       /**< Channel description, see below */
#define SPDIF_CSTAT1_SFREQMASK          (0x000F << 8)       /**< Sampling frequency, see below */
#define SPDIF_CSTAT1_CLKMASK            (0x0003 << 12)      /**< Clock accuracy, see below */

// Bits in the SPDIF channel status word #2
#define SPDIF_CSTAT2_WLENMASK           (0x000F << 0)       /**< Word length, see below */
#define SPDIF_CSTAT2_ORG_SFREQMASK      (0x000F << 4)       /**< Original sampling frequency, see below */
#define SPDIF_CSTAT2_CGMSMASK           (0x0003 << 8)       /** Copyright management guide, see below */

/***************************** WORD 1 specific values *****************************/

// Channels
#define SPDIF_CSTAT1_STEREO_LEFT        (0x0001 << 4)
#define SPDIF_CSTAT1_STEREO_RIGHT       (0x0002 << 4)

// Sampling frequency:
#define SPDIF_CSTAT1_44KHZ              (0x0000 << 8)       /**< 44.1 kHz */
#define SPDIF_CSTAT1_48KHZ              (0x0002 << 8)       /**< 48 kHz */
#define SPDIF_CSTAT1_32KHZ              (0x0003 << 8)       /**< 32 kHz */
#define SPDIF_CSTAT1_22KHZ              (0x0004 << 8)       /**< 22.05 kHz */
#define SPDIF_CSTAT1_24KHZ              (0x0006 << 8)       /**< 24 kHz */
#define SPDIF_CSTAT1_88KHZ              (0x0008 << 8)       /**< 88.2 kHz */
#define SPDIF_CSTAT1_768KHZ             (0x0009 << 8)       /**< 768 kHz */
#define SPDIF_CSTAT1_96KHZ              (0x000A << 8)       /**< 96 kHz */
#define SPDIF_CSTAT1_176KHZ             (0x000C << 8)       /**< 176 kHz */
#define SPDIF_CSTAT1_192KHZ             (0x000E << 8)       /**< 192 kHz */

// Clock accuracy
#define SPDIF_CSTAT1_CLK_DEF            (0x0000 << 12)      /**< Default clock acuracy */
#define SPDIF_CSTAT1_CLK_HIGH           (0x0001 << 12)      /**< High clock acuracy */
#define SPDIF_CSTAT1_CLK_VAR            (0x0002 << 12)      /**< Variable pitch clock acuracy */
#define SPDIF_CSTAT1_CLK_MISMATCH       (0x0003 << 12)      /**< Interface frame rate not matched to sampling frequency */

/***************************** WORD 2 specific values *****************************/

// Word length
#define SPDIF_CSTAT2_WORD_MAX20         (0x0000 << 0)       /**< Audio sample word length max is 20 bits */
#define SPDIF_CSTAT2_WORD_MAX24         (0x0001 << 0)       /**< Audio sample word length max is 24 bits */

#define SPDIF_CSTAT2_WORD_SUBTRACT_4    (0x0001 << 1)       /**< Actual audio word length is max - 4 bits */
#define SPDIF_CSTAT2_WORD_SUBTRACT_2    (0x0002 << 1)       /**< Actual audio word length is max - 2 bits */
#define SPDIF_CSTAT2_WORD_SUBTRACT_1    (0x0004 << 1)       /**< Actual audio word length is max - 1 bit */
#define SPDIF_CSTAT2_WORD_SUBTRACT_0    (0x0005 << 1)       /**< Actual audio word length is max bits */
#define SPDIF_CSTAT2_WORD_SUBTRACT_3    (0x0006 << 1)       /**< Actual audio word length is max - 3 bits */

// Original sampling frequency
#define SPDIF_CSTAT2_ORGFREQ_192KHZ     (0x0001 << 4)       /**< Original sample frequency is 192 kHz */
#define SPDIF_CSTAT2_ORGFREQ_12KHZ      (0x0002 << 4)       /**< Original sample frequency is 12 kHz */
#define SPDIF_CSTAT2_ORGFREQ_176KHZ     (0x0003 << 4)       /**< Original sample frequency is 176.4 kHz */
#define SPDIF_CSTAT2_ORGFREQ_96KHZ      (0x0005 << 4)       /**< Original sample frequency is 96 kHz */
#define SPDIF_CSTAT2_ORGFREQ_8KHZ       (0x0006 << 4)       /**< Original sample frequency is 8 kHz */
#define SPDIF_CSTAT2_ORGFREQ_88KHZ      (0x0007 << 4)       /**< Original sample frequency is 88.2 kHz */
#define SPDIF_CSTAT2_ORGFREQ_16KHZ      (0x0008 << 4)       /**< Original sample frequency is 16 kHz */
#define SPDIF_CSTAT2_ORGFREQ_24KHZ      (0x0009 << 4)       /**< Original sample frequency is 24 kHz */
#define SPDIF_CSTAT2_ORGFREQ_11KHZ      (0x000A << 4)       /**< Original sample frequency is 11.025 kHz */
#define SPDIF_CSTAT2_ORGFREQ_22KHZ      (0x000B << 1)       /**< Original sample frequency is 22.05 kHz */
#define SPDIF_CSTAT2_ORGFREQ_32KHZ      (0x000C << 4)       /**< Original sample frequency is 32 kHz */
#define SPDIF_CSTAT2_ORGFREQ_48KHZ      (0x000D << 4)       /**< Original sample frequency is 48 kHz */
#define SPDIF_CSTAT2_ORGFREQ_44KHZ      (0x000F << 4)       /**< Original sample frequency is 44.1 kHz */

// CGMS-A copyright management
#define SPDIF_CSTAT2_COPY_PERMITTED     (0x0000 << 8)       /**< Copying is permitted without restriction */
#define SPDIF_CSTAT2_COPY_LIMITED       (0x0001 << 8)       /**< One generation of copies may be made */
#define SPDIF_CSTAT2_COPY_DENIED        (0x0003 << 8)       /**< No copying is permitted */

#endif // _SPDIF_CSTAT_H
