/******************************************************************************
|*
|*  COPYRIGHT:      Copyright 2007 Altium BV
|*
|*  DESCRIPTION:    FAT file system long file name support.
|*
\******************************************************************************/

#include <io.h>
#include <ctype.h>
#include <string.h>

#include "fat.h"
#include "fat_lfn.h"
#include "fat_layout.h"

//------------------------------------------------------------
// DIRECTORY SFN/LFN SUPPORT FUNCTIONS

// return 1 for legal SFN character, 0 for illegal
static int sfn_validchar( char c )
{
    uint8_t uc = ( uint8_t ) c;

    // validates chars according to Microsoft spec
    if ( ( uc < 0x20 ) ||
         ( uc == 0x22 ) || ( uc == 0x2A ) || ( uc == 0x2B ) || ( uc == 0x2C ) || ( uc == 0x2E )
         || ( uc == 0x2F ) || ( uc == 0x3A ) || ( uc == 0x3B ) || ( uc == 0x3C ) || ( uc == 0x3D )
         || ( uc == 0x3E ) || ( uc == 0x3F ) || ( uc == 0x5B ) || ( uc == 0x5C ) || ( uc == 0x5D )
         || ( uc == 0x7C ) )
    {
        return 0;
    }

    return 1;
}

// convert given C-string 8.3 type name into 'Short File Name'
// return 1 when OK, 0 for illegal name
extern int shortname2sfn( const char *name, uint8_t *sfn, int volumelabel )
{
    uint8_t count;

    if ( *name == '.' )
    {
        return 0;
    }                           // no base name

    for ( count = ( volumelabel ? 11 : 8 ); count; --count )
    {
        if ( !*name || ( *name == '.' ) )
        {
            *sfn = ' ';
        }
        else if ( !sfn_validchar( *name ) )
        {
            return 0;
        }                       // invalid character
        else
        {
            *sfn = (uint8_t)toupper( *name++ );
        }
        ++sfn;
    }

    if ( volumelabel )
    {
        return 1;
    }

    if ( *name == '.' )
    {
        ++name;
    }
    else if ( *name )
    {
        return 0;
    }                           // base name too long

    for ( count = 3; count; --count )
    {
        if ( !*name )
        {
            *sfn = ' ';
        }
        else if ( !sfn_validchar( *name ) )
        {
            return 0;
        }                       // invalid character
        else
        {
            *sfn = (uint8_t)toupper( *name++ );
        }
        ++sfn;
    }

    if ( *name )
    {
        return 0;
    }                           // extension too long

    return 1;
}

// convert given 'Short File Name' into C-string 8.3 type name or volume label
extern void sfn2shortname( const uint8_t *sfn, char *name, uint8_t volumelabel )
{
    uint8_t pos;
    for ( pos = 8; pos; --pos )
    {
        if ( *sfn != ' ' )
        {
            *name++ = *sfn;
        }
        ++sfn;
    }

    if ( !volumelabel && ( *sfn != ' ' ) )
    {
        *name++ = '.';
    }

    for ( pos = 3; pos; --pos )
    {
        if ( *sfn != ' ' )
        {
            *name++ = *sfn;
        }
        ++sfn;
    }
    *name = 0;
}

#if FATFS_USE_LFN
// convert long C-string name to default 8.3 name and calculate LFN slots needed
extern int longname2sfn( const char *name, uint8_t *sfn )
{
    int pos;
    const char *p;

    // create a default SFN
    pos = 0;
    p = name;
    while ( pos <= 10 )
    {
        if ( p && ( *p == ' ' ) )
        {
            ++p;
        }
        else
        {
            if ( !p || !*p || ( *p == '.' ) )
            {
                sfn[pos++] = ' ';
            }
            else
            {
                sfn[pos++] = (uint8_t)toupper( *p++ );
            }

            if ( pos == 8 )
            {
                p = strrchr( p, '.' );
                if ( p )
                {
                    ++p;
                }
            }
        }
    }

    return ( strlen( name ) + 12 ) / 13;
}
#endif

#if FATFS_USE_LFN
// brute force conversion ASCII to unicode
inline static int asc2unicode( uint8_t *c_unicode, int c_asc )
{
//    if (c_asc == ' ')
//    { c_unicode[0] = 0xFF; }
//    else
    if ( c_asc == -1 )
    {
        c_unicode[0] = 0xFF;
        c_unicode[1] = 0xFF;
        return 1;
    }
    else
    {
        c_unicode[0] = ( uint8_t ) c_asc;
        c_unicode[1] = 0;
        return c_asc ? 0 : 1;
    }
}
#endif

#if FATFS_USE_LFN
// convert given long C-string name to given direntry slot describing part of 'Long File Name'
extern void longname2lfn( const char *name, fat_direntry_lfn_t * direntry_lfn )
{
    int filler = 0;
    name += 13 * ( ( direntry_lfn->slotnumber & 0x0F ) - 1 );

    filler = asc2unicode( direntry_lfn->unicode_0, *name++ );
    filler = asc2unicode( direntry_lfn->unicode_1, filler ? -1 : *name++ );
    filler = asc2unicode( direntry_lfn->unicode_2, filler ? -1 : *name++ );
    filler = asc2unicode( direntry_lfn->unicode_3, filler ? -1 : *name++ );
    filler = asc2unicode( direntry_lfn->unicode_4, filler ? -1 : *name++ );
    filler = asc2unicode( direntry_lfn->unicode_5, filler ? -1 : *name++ );
    filler = asc2unicode( direntry_lfn->unicode_6, filler ? -1 : *name++ );
    filler = asc2unicode( direntry_lfn->unicode_7, filler ? -1 : *name++ );
    filler = asc2unicode( direntry_lfn->unicode_8, filler ? -1 : *name++ );
    filler = asc2unicode( direntry_lfn->unicode_9, filler ? -1 : *name++ );
    filler = asc2unicode( direntry_lfn->unicode_10, filler ? -1 : *name++ );
    filler = asc2unicode( direntry_lfn->unicode_11, filler ? -1 : *name++ );
    asc2unicode( direntry_lfn->unicode_12, filler ? -1 : *name++ );
}
#endif

#if FATFS_USE_LFN
// brute force conversion unicode to ASCII
inline static char unicode2asc( uint8_t *c_unicode )
{
    if ( ( c_unicode[0] == 0xFF ) & ( c_unicode[1] == 0xFF ) )
    {
        return 0;
    }
    if ( c_unicode[1] != 0 )
    {
        return '_';
    }                           // unsupported char for this implementation
    else
    {
        return c_unicode[0];
    }
}
#endif

#if FATFS_USE_LFN
// convert direntry with part of 'Long File Name' into C-string
extern void lfn2name( fat_direntry_lfn_t * direntry_lfn, char *name, size_t size )
{
    size_t n = 13 * ( ( direntry_lfn->slotnumber & 0x0F ) - 1 );

    if ( size > n )
    {
        name += n;
        size -= n;

        switch ( size )
        {
        default:
            size = 14;
            *(name + 12) = unicode2asc( direntry_lfn->unicode_12 );
            /* fall through */
        case 13:
            *(name + 11) = unicode2asc( direntry_lfn->unicode_11 );
            /* fall through */
        case 12:
            *(name + 10) = unicode2asc( direntry_lfn->unicode_10 );
            /* fall through */
        case 11:
            *(name + 9) = unicode2asc( direntry_lfn->unicode_9 );
            /* fall through */
        case 10:
            *(name + 8) = unicode2asc( direntry_lfn->unicode_8 );
            /* fall through */
        case 9:
            *(name + 7) = unicode2asc( direntry_lfn->unicode_7 );
            /* fall through */
        case 8:
            *(name + 6) = unicode2asc( direntry_lfn->unicode_6 );
            /* fall through */
        case 7:
            *(name + 5) = unicode2asc( direntry_lfn->unicode_5 );
            /* fall through */
        case 6:
            *(name + 4) = unicode2asc( direntry_lfn->unicode_4 );
            /* fall through */
        case 5:
            *(name + 3) = unicode2asc( direntry_lfn->unicode_3 );
            /* fall through */
        case 4:
            *(name + 2) = unicode2asc( direntry_lfn->unicode_2 );
            /* fall through */
        case 3:
            *(name + 1) = unicode2asc( direntry_lfn->unicode_1 );
            /* fall through */
        case 2:
            *name = unicode2asc( direntry_lfn->unicode_0 );
            /* fall through */
        case 1:
            /* do nothing (just write '\0' below) */
            break;
        }

        if ( direntry_lfn->slotnumber & 0x40 || size < 14 ) // last slot or no more space left
        {
            *(name + size - 1) = '\0';
        }
    }
}
#endif

#if FATFS_USE_LFN
// test new sfn agains an existing one and return the next tailnumber wich would make them different
extern int sfn_nexttail( uint8_t *newsfn, uint8_t *sfn )
{
    int tailnr = 0;

    // compare extension
    for ( int i = 8; i <= 10; ++i )
    {
        if ( newsfn[i] != sfn[i] )
        {
            return 0;
        }                       // extension differs
    }

    // compare basename
    for ( int i = 0; i <= 7; ++i )
    {
        if ( newsfn[i] != sfn[i] )
        {
            while ( sfn[i] == '~' )
            {
                ++i;
            }

            // possible tailnr
            for ( ; ( i <= 7 ) && sfn[i]; ++i )
            {
                if ( !isdigit( sfn[i] ) )
                {
                    return 0;
                }               // not a tailnr after all: basename differs

                tailnr *= 10;
                tailnr += sfn[i] - '0';
            }
        }
    }

    // equal except for the tailnr
    return tailnr + 1;
}
#endif

#if FATFS_USE_LFN
// calculate checksum over given 'Short File Name' which is used
// to mark the 'Long File Name' direntry slots
extern uint8_t sfn_checksum( const uint8_t *sfn )
{
    uint8_t sum = 0;

    for ( int len = 11; len; --len )
    {
        sum = ( ( sum & 1 ) ? 0x80 : 0 ) + ( sum >> 1 ) + *sfn++;
    }

    return sum;
}
#endif
