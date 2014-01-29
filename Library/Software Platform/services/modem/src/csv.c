#include <string.h>
#include <stdint.h>
#include <stdbool.h>
#include <assert.h>
/**
 * @brief    Tokenise a line of Comma-Separated-Value data
 *
 * This function initializes the service and opens the drivers beneath first time the service is called.
 * Further attemps to open an already opened instance of the service simply returns the same pointer.
 *
 * @param  csv          the comma-separated-value text
 * @param  csv_max_len  the length of the csv buffer
 * @param  ptr_array    an array of char * pointers to receive pointers to each token
 * @param  ptr_count    the length of ptr_array
 *
 * @return The number of characters processed. This can be used to locate the start of the next line, if there is one.
 */

int tokenize_csv_line(char * csv, int csv_max_len, char ** ptr_array, int * ptr_count)
{
    bool new_field = true;
    bool in_quotes = false;
    int c = 0, p = 0;

    assert(csv && ptr_array && ptr_count);

    for(c=0;c < csv_max_len;c++)
    {
        switch (csv[c])
        {
        case ',':
            if (!in_quotes)
            {
               csv[c] = '\0';
               new_field = true;
            }
            break;
        case '"':
            if (in_quotes)
            {
                if (csv[c+1] == '"')
                {
                    csv[c++] = ' '; // not strictly correct but it saves shifting the whole string
                }
                else
                {
                    in_quotes = false;
                    csv[c]  = '\0';
                }
            }
            else
            {
                in_quotes = true;
                csv[c]  = '\0';
            }
            break;
        case '\r':
        case '\n':
            while (csv[c] == '\r' || csv[c] == '\n')
                csv[c++] = '\0';
            /* fall through */
        case '\0':
            *ptr_count = p;
            return c;
        default:
            if (p < *ptr_count && new_field)
            {
                ptr_array[p++] = csv + c;
            }
            new_field = false;
            break;
        }
    }
    *ptr_count = p;
    csv[csv_max_len-1] = '\0';
    return csv_max_len-1;
}
