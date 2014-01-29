/*************************************************************************
|*
|*  VERSION CONTROL:    $Version$   $20/10/2009$
|*
|*  IN PACKAGE:         
|*
|*  COPYRIGHT:          Copyright (c) 2009, Altium
|*
|*  DESCRIPTION:        
|*
 */

#ifndef CSV_H_
#define CSV_H_

#ifdef  __cplusplus
extern "C" {
#endif

int tokenize_csv_line(char * csv, int csv_max_len, char ** ptr_array, int * ptr_count);

#ifdef  __cplusplus
}
#endif

#endif /* CSV_H_ */
