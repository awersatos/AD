/*
 * wepkey.h - Generate WEP keys from a given passphrase
 *
 * Impliments defacto standard paraphrase to WEP key algorithm
 *
 * Based on algorithm - http://svn.dd-wrt.com:8000/dd-wrt/browser/src/router/httpd/modules/wepkey.c?rev=631
 */

#ifndef __WEP_KEY_H
#define __WEP_KEY_H

#include <sys/types.h>


#define WEPKEY_64_BYTES     5
#define WEPKEY_128_BYTES    13

int Generate_WEP40_Key  (uint8_t *key, int32_t keyLen, const uint8_t *paraPhrase, int32_t keyIdx);
int Generate_WEP104_Key (uint8_t *key, int32_t keyLen, const uint8_t *paraPhrase, int32_t keyIdx);

#endif /* __WEP_KEY_H */

