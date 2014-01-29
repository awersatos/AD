/*
 * usbhost_msd_print.c
 */

#include <assert.h>
#include <stdio.h>
#include <usbhost_mass_storage.h>
#include <usbhost_msd_print.h>

static char *response_code_to_str(uint8_t response_code)
{
    switch (response_code)
    {
        case SCSI_SENSE_CURRENT_ERROR:
            return "current error";
        case SCSI_SENSE_DEFERRED_ERROR:
            return "deferred error";
        default:
            return "unknown response_code";
    }
}

static char *sense_key_to_str(uint8_t sense_key)
{
    switch (sense_key)
    {
        case SCSI_SENSE_KEY_NO_SENSE:
            return "NO SENSE";
        case SCSI_SENSE_KEY_RECOVERED_ERROR:
            return "RECOVERED ERROR";
        case SCSI_SENSE_KEY_NOT_READY:
            return "NOT READY";
        case SCSI_SENSE_KEY_MEDIUM_ERROR:
            return "MEDIUM_ERROR";
        case SCSI_SENSE_KEY_HARDWARE_ERROR:
            return "HARDWARE ERROR";
        case SCSI_SENSE_KEY_ILLEGAL_REQUEST:
            return "ILLEGAL REQUEST";
        case SCSI_SENSE_KEY_UNIT_ATTENTION:
            return "UNIT ATTENTION";
        case SCSI_SENSE_KEY_DATA_PROTECT:
            return "DATA PROTECT";
        case SCSI_SENSE_KEY_BLANK_CHECK:
            return "BLANK CHECK";
        case SCSI_SENSE_KEY_VENDOR_SPECIFIC:
            return "VENDOR SPECIFIC";
        case SCSI_SENSE_KEY_COPY_ABORTED:
            return "COPY ABORTED";
        case SCSI_SENSE_KEY_ABORTED_COMMAND:
            return "ABORTED COMMAND";
        case 0x0C:
            return "Obsolete 0x0C";
        case SCSI_SENSE_KEY_VOLUME_OVERFLOW:
            return "VOLUME OVERFLOW";
        case SCSI_SENSE_KEY_MISCOMPARE:
            return "KEY_MISCOMPARE";
        case 0x0F:
            return "Reserved 0x0F";
        default:
            return "unknown sense_key";
    }
}

void usbhost_msd_print_sense_response( FILE *fp, scsi_sense_response_t *response)
{
    if (fp == NULL)
    {
        fp = stdout;
    }
    assert(response != 0);

    if (response->valid == 0)
    {
        fprintf(fp, "sense_response valid bit not set\n");
    }
    else
    {
        fprintf(fp, "response_code  \"%s\"\n", response_code_to_str(response->response_code));
        fprintf(fp, "sense_key      \"%s\"\n", sense_key_to_str(response->sense_key));
        // TODO fillin the rest of the fields
    }
}

