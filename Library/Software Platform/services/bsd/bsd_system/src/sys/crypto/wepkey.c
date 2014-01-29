/*
 * wepkey.h - Generate WEP keys from a givrn passphrase
 *
 * Impliments defacto standard paraphrase to WEP key algorithm
 *
 * Based on algorithm - http://svn.dd-wrt.com:8000/dd-wrt/browser/src/router/httpd/modules/wepkey.c?rev=631
 */


#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <crypto/md5.h>

#include "wepkey.h"

int Generate_WEP40_Key(uint8_t *key, int32_t keyLen, const uint8_t *paraPhrase, int32_t keyIdx)
{
    int32_t len, i;
    uint32_t prn;
    uint8_t *p;

    if (keyLen < WEPKEY_64_BYTES)
        return -1;
    if (keyIdx < 0 || keyIdx >= 4)
        return -1;

    len = strlen((const char *)paraPhrase);
    if (!len)
        return -1;

    prn = 0;
    for (i = 0; i != len; i++)
        prn ^= ((uint8_t *) paraPhrase)[i] << (8*(i & 3));
    for (i = 0; i != keyIdx*WEPKEY_64_BYTES; i++) {
        prn *= 0x343fd;
        prn += 0x269ec3;
    }
    for (p = key; p != key+WEPKEY_64_BYTES; p++) {
        prn *= 0x343fd;
        prn += 0x269ec3;
        *p = prn >> 16;
    }
    return WEPKEY_64_BYTES;
}

int Generate_WEP104_Key (uint8_t *key, int32_t keyLen, const uint8_t *paraPhrase, int32_t keyIdx)
{
    const uint8_t extra[] = "#$%" "!@#" "%&^";
    MD5_CTX ctx;
    uint8_t buf[64];
    uint8_t tmp[16];
    int32_t len, i, j;

    if (keyLen < WEPKEY_128_BYTES)
        return -1;
    if (keyIdx < 0 || keyIdx >= 4)
        return -1;

    len = strlen((const char *)paraPhrase);
    if (!len)
        return -1;

    for (i = 0; i != sizeof(buf); i++) {
        j = i % (len+keyIdx*3);
        buf[i] = j < len ? paraPhrase[j] : extra[j-len];
    }
    MD5Init(&ctx);
    MD5Update(&ctx, buf, sizeof(buf));
    MD5Final(tmp, &ctx);
    memcpy(key, tmp+keyIdx, WEPKEY_128_BYTES);
    return WEPKEY_128_BYTES;
}

