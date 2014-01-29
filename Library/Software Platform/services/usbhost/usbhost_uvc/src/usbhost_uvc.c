/**
 * @file
 *  USB Host Universal Video Class Device service
 *
 */

#include <assert.h>
#include <stdio.h>
#include <string.h>

#include <usbhost_uvc.h>
#include <usbhost_uvc_cfg_instance.h>

#include <usbhost.h>
#include <usbhost_device.h>
#include <usbhost_message.h>

#include <util_endian.h>

#define USBHOST_UVC_FBUFSIZE          3


typedef struct usbhost_uvc_dev_info_s usbhost_uvc_dev_info_t;

typedef struct usbhost_uvc_frame_s
{
    uint8_t                         *buf;      // the actual frame data
    uint32_t                        bufsize;   // bytes placed in this buffer
} usbhost_uvc_frame_t;

/*typedef struct usbhost_uvc_pu_controls_s
{
    uint16_t wBacklightCompensation;
    int16_t  wBrightness;
    uint16_t wContrast;
    uint16_t wGain;
    uint8_t  bPowerLineFrequency;
    int16_t  wHue;
    uint8_t  bHueAuto;
    uint16_t wSaturation;
    uint16_t wSharpness;
    uint16_t wGamma;
    uint16_t wWhiteBalanceTemperature;
    uint16_t bWhiteBalanceTemperatureAuto;
    uint16_t wWhiteBalanceBlue;
    uint16_t wWhiteBalanceRed;
    uint8_t  bWhiteBalanceComponentAuto;
    uint16_t wMultiplierStep;
    uint16_t wMultiplierLimit;
    uint8_t  bVideoStandard;
    uint8_t  bStatus;
} usbhost_uvc_pu_controls_t; */

// usbhost uvc driver structure
struct usbhost_uvc_s
{
    usbhost_t                 *usbhost;
    usbhost_device_t          *dev;
    usbhost_interface_t       *cintf;           // video control interface
    usbhost_interface_t       *sintf;           // video streaming interface
    usbhost_host_endpoint_t   *ep;
    uint32_t                  altsetting;       // selected alternate setting for endpoint
    uint8_t                   mjpegformatindex; // the format index used for mjpeg
    uint8_t                   mjpegframeindex;  // frameindex closest to 320 x 240
    uint16_t                  puctrls[4][16];   // current, min, max and default setting of the processing unit controls
    usbhost_uvc_state_t       state;
    usbhost_uvc_frame_t       frame[USBHOST_UVC_FBUFSIZE];
    int                       ftail;           // frames are retrieved from tail
    int                       fhead;           // frames are added to head
    uint32_t                  fbuflen;         // length of the buffer
    uint8_t                   last_frameid;
};

static usbhost_uvc_t usbhost_uvc_driver_table[USBHOST_UVC_INSTANCE_COUNT];

#if DEBUG_USBHOST_UVC
static void usbhost_uvc_print_vc_header_descriptor(const usbhost_uvc_streaming_control_t *ctrl)
{
    printf("VideoStreaming Control Parameters:\n");
    printf("  bmHint                 0x%x\n", little16(ctrl->bmHint));
    printf("  bFormatIndex             %d\n", ctrl->bFormatIndex);
    printf("  bFrameIndex              %d\n", ctrl->bFrameIndex);
    printf("  dwFrameInterval          %u (%u fps)\n", little32(ctrl->dwFrameInterval), 10000000 / little32(ctrl->dwFrameInterval));
    printf("  wKeyFrameRate            %u\n", little16(ctrl->wKeyFrameRate));
    printf("  wPFrameRate              %u\n", little16(ctrl->wPFrameRate));
    printf("  wCompQuality             %u\n", little16(ctrl->wCompQuality));
    printf("  wCompWindowSize          %u\n", little16(ctrl->wCompWindowSize));
    printf("  wDelay                   %u\n", little16(ctrl->wDelay));
    printf("  dwMaxVideoFrameSize      %u\n", little32(ctrl->dwMaxVideoFrameSize));
    printf("  dwMaxPayloadTransferSize %u\n", little32(ctrl->dwMaxPayloadTransferSize));
    printf("  dwClockFrequency         %u\n", little32(ctrl->dwClockFrequency));
    printf("  bmFramingInfo          0x%x\n", little16(ctrl->bmFramingInfo));
    printf("  bPreferedVersion         %d\n", ctrl->bPreferedVersion);
    printf("  bMinVersion              %d\n", ctrl->bMinVersion);
    printf("  bMaxVersion              %d\n", ctrl->bMaxVersion);
}
#endif

// build control request for UVC class devices. This command will build
// the control requests mentioned in chapter 4 of the UVC spec.
static void usbhost_uvc_buildcontrolrequest(usbhost_host_endpoint_t *ep, uint8_t req, uint8_t cs, uint8_t unit,
            uint8_t intfnum, uint16_t len, usbhost_controlrequest_t *creq)
{
    if (req & 0x80)
        creq->bmRequestType = USBHOST_DIR_IN | USBHOST_TYPE_CLASS;
    else
        creq->bmRequestType = USBHOST_DIR_OUT |USBHOST_TYPE_CLASS;
    if(ep)
        creq->bmRequestType |= USBHOST_RECIP_ENDPOINT;
    else
        creq->bmRequestType |= USBHOST_RECIP_INTERFACE;

    creq->bRequest      = req;
    creq->wValue        = little16(cs << 8);
    creq->wIndex        = little16(unit << 8 | intfnum);
    creq->wLength       = little16(len);
}

static int usbhost_uvc_docontrolrequest(usbhost_uvc_t *drv, void *buf, uint16_t buflen, uint8_t req, uint8_t cs)
{
    int ret = 0;
    usbhost_controlrequest_t creq;

    usbhost_uvc_buildcontrolrequest(NULL, req, cs, 0, 1, buflen, &creq);
    if (!usbhost_docontrolrequest(drv->dev, &creq, buf, buflen))
    {
        ret = -EIO;
    }
    return ret;
}


static int usbhost_uvc_set_alternate_interface(usbhost_uvc_t *drv, usbhost_interface_t *intf, uint32_t i)
{
    int ret = 0;
    usbhost_controlrequest_t creq;

    usbhost_buildsetinterface(intf->altIntf[i].desc.bInterfaceNumber, intf->altIntf[i].desc.bAlternateSetting, &creq);
    if (!usbhost_docontrolrequest(drv->dev, &creq, NULL, 0))
    {
        ret = -EIO;
    }
    return ret;
}


static uint8_t usbhost_uvc_find_stream_mjpeg(usbhost_uvc_t *drv)
{
    usbhost_host_interface_t    *sintf = drv->sintf->curIntf;
    uint8_t                     *rawdesc = sintf->extra;
    uint8_t                     epaddress = 0;
    uint16_t                    width = 0;

    while (rawdesc < sintf->extra + sintf->extralen)
    {
        if (((usbhost_csdescriptorheader_t *)rawdesc)->bDescriptorType == USBHOST_DT_CS_INTERFACE)
        {
            switch (((usbhost_csdescriptorheader_t *)rawdesc)->bDescriptorSubtype)
            {
            case USBHOST_UVC_VS_INPUT_HEADER:
                epaddress = ((usbhost_uvc_vs_input_header_descriptor_t *)rawdesc)->bEndpointAddress;
                break;
            case USBHOST_UVC_VS_FORMAT_MJPEG:
                drv->mjpegformatindex = ((usbhost_uvc_vs_format_mjpeg_descriptor_t *)rawdesc)->bFormatIndex;
                break;
            case USBHOST_UVC_VS_FRAME_MJPEG:
            {
                usbhost_uvc_vs_frame_mjpeg_descriptor_t *frame_desc = (usbhost_uvc_vs_frame_mjpeg_descriptor_t *)rawdesc;

                if ((little16(frame_desc->wWidth) > width) && (little16(frame_desc->wWidth) <= 320) &&
                    (little16(frame_desc->wHeight) <= 240))
                {
                    drv->mjpegframeindex = frame_desc->bFrameIndex;
                    width = little16(frame_desc->wWidth);
                }
                break;
            }
            default:;
            }
        }
        rawdesc += ((usbhost_csdescriptorheader_t *)rawdesc)->bLength;
    }
    if(drv->mjpegformatindex && drv->mjpegframeindex)
        return epaddress;
    else
        return 0;
}


static bool usbhost_uvc_find_video_iad(usbhost_uvc_t *drv, usbhost_device_t *usbdevice)
{
    usbhost_ifassociationdescriptor_t *iad;
    usbhost_interface_t               *intf;

    for (uint32_t i = 0; i < USBHOST_MAXIADS; i++)
    {
        iad = usbdevice->config->intf_assoc[i];
        if (iad && (iad->bFunctionClass == USBHOST_BC_VIDEO))
        {
            for (uint32_t i = iad->bFirstInterface; i < iad->bFirstInterface + iad->bInterfaceCount; i++)
            {
                intf = usbhost_getfunctioninterface(i, usbdevice);
                switch (intf->curIntf->desc.bInterfaceSubClass)
                {
                case USBHOST_UVC_SC_VIDEOCONTROL:
                    drv->cintf = intf;
                    break;
                case USBHOST_UVC_SC_VIDEOSTREAMING:
                    drv->sintf = intf;
                    break;
                default:;
                }
            }
            return true;
        }
    }
    return false;
}


/*
 * test new USB device for uvc
 */
static bool usbhost_uvc_connect_test(void *devicedrv, usbhost_device_t *usbdevice)
{
    usbhost_uvc_t                   *drv = (usbhost_uvc_t *)devicedrv;
    usbhost_interface_t             *intf;
    uint16_t                        maxpsize = 0;
    uint32_t                        altsetting = 0;
    uint8_t                         epaddress;

    // verify if we are a driver for this device
    if ((usbdevice->desc.bDeviceClass != USBHOST_BC_MISCELLANEOUS) ||
        (usbdevice->desc.bDeviceSubClass != USBHOST_BSC_COMMON) ||
        (usbdevice->desc.bDeviceProtocol != USBHOST_PROT_IAD))
        return false;
    if (!usbhost_uvc_find_video_iad(drv, usbdevice))
        return false;

#if DEBUG_USBHOST_UVC
    printf("UVC device connected\n");
#endif

    epaddress = usbhost_uvc_find_stream_mjpeg(drv);
    if(epaddress)
    {
        intf = drv->sintf;

        for(uint32_t i = 0; i < intf->altCount; i++)
        {
            if ((intf->altIntf[i].endpoint[0].desc.bEndpointAddress == epaddress) &&
                !((little16(intf->altIntf[i].endpoint[0].desc.wMaxPacketSize) >> 11) & 3) &&
                ((little16(intf->altIntf[i].endpoint[0].desc.wMaxPacketSize) & 0x7ff) > maxpsize))
            {
                maxpsize = little16(intf->altIntf[i].endpoint[0].desc.wMaxPacketSize) & 0x7ff;
                altsetting = i;
            }
        }
        if (maxpsize)
        {
#if DEBUG_USBHOST_UVC
    printf("UVC maxpacket size %d\n", maxpsize);
#endif
            drv->dev = usbdevice;
            drv->ep = &intf->altIntf[altsetting].endpoint[0];
            drv->altsetting = altsetting;
        }
        else
        {
#if DEBUG_USBHOST_UVC
            printf("No valid MJPEG endpoint found\n");
#endif
            return false;
        }
    }
    else
    {
#if DEBUG_USBHOST_UVC
        printf("No valid MJPEG stream found\n");
#endif
        return false;
    }
//    usbhost_uvc_find_pucontrols(drv);
    drv->state = USBHOST_UVC_STATE_CONNECTED;
    return true;
}


static void usbhost_uvc_disconnect_test(void *devicedrv, usbhost_device_t *usbdevice)
{
    usbhost_uvc_t           *drv = (usbhost_uvc_t *) devicedrv;

    // verify if we are a driver for this device
    if (usbdevice->desc.bDeviceClass)
    {
        if ((usbdevice->desc.bDeviceClass != USBHOST_BC_MISCELLANEOUS) ||
            (usbdevice->desc.bDeviceSubClass != USBHOST_BSC_COMMON) ||
            (usbdevice->desc.bDeviceProtocol != USBHOST_PROT_IAD))
        {
            return;
        }
    }
    else
    {
        if (usbdevice->config->intf_assoc[0]->bFunctionClass != USBHOST_BC_VIDEO)
        {
            return;
        }
    }
#if DEBUG_USBHOST_UVC
    printf("UVC device disconnected\n");
#endif
    for(int i = 0; i < USBHOST_UVC_FBUFSIZE; i++)
    {
        free (drv->frame[i].buf);
    }

    drv->state = USBHOST_UVC_STATE_NOTCONNECTED;
}

// urb completion handler
static void usbhost_uvc_video_complete(usbhost_urb_t *urb)
{
    usbhost_uvc_t                *drv = (usbhost_uvc_t *)urb->completecontext;
    usbhost_uvc_payload_header_t *hdr;
    usbhost_uvc_frame_t          *frame = &drv->frame[drv->fhead];
    uint8_t                      *urb_buf;
    uint8_t                      *urb_data;
    uint8_t                      *frame_data;
    uint8_t                      frameid;
    int                          len;
    int                          next;

    if (drv->state != USBHOST_UVC_STATE_STOPPED)
    {
        for (int i = 0; i < urb->isoframecount; i++)
        {
            // isoframe should be ok and hdr must contain a bmHeaderInfo and a bHeaderLength (2 bytes)
            if (!urb->isoframes[i].status && (urb->isoframes[i].actuallen >= 2))
            {
                // Decode the payload header.
                urb_buf = (uint8_t *)urb->xferbuf + urb->isoframes[i].offset;
                hdr     = (usbhost_uvc_payload_header_t *)urb_buf;

                frameid = hdr->bmHeaderInfo & USBHOST_UVC_FRAME_ID;
                len = urb->isoframes[i].actuallen - hdr->bHeaderLength;

                if (!(hdr->bmHeaderInfo & USBHOST_UVC_STREAM_ERROR) && (len >= 0))
                {
                    if (drv->state != USBHOST_UVC_STATE_ACTIVE)
                    {
                        if (frameid != drv->last_frameid)
                        {
                            if (drv->fhead == USBHOST_UVC_FBUFSIZE - 1)
                                next = 0;
                            else
                                next = drv->fhead + 1;
                            if (next != drv->ftail) // if the queue is not full
                            {
                                frame = &drv->frame[next];
                                frame->bufsize = 0;
                                drv->fhead = next;
                                drv->state = USBHOST_UVC_STATE_ACTIVE;
                            }
                            else
                            {
                                drv->state = USBHOST_UVC_STATE_ERROR;
                            }
                        }
                    }
                    if (drv->state == USBHOST_UVC_STATE_ACTIVE)
                    {
                        // copy the payload data.
                        if (frame->bufsize + len > drv->fbuflen)
                        {
                            drv->state = USBHOST_UVC_STATE_ERROR;
                            frame->bufsize = 0;
                        } else
                        {
                            urb_data = urb_buf + hdr->bHeaderLength;
                            frame_data = frame->buf + frame->bufsize;
                            frame->bufsize += len;
                            memcpy(frame_data, urb_data, len);

                            // Mark the buffer as done if the EOF marker is set.
                            if (hdr->bmHeaderInfo & USBHOST_UVC_END_OF_FRAME)
                                drv->state = USBHOST_UVC_STATE_DONE;
                        }
                    }
                    drv->last_frameid = frameid;
                } else // drop frame
                {
                    frame->bufsize = 0;
                    drv->state = USBHOST_UVC_STATE_ERROR;
                }
            } else
            {
                    frame->bufsize = 0;
                    drv->state = USBHOST_UVC_STATE_ERROR;
#if DEBUG_USBHOST_UVC
                    printf("frame error(%d)\n", urb->isoframes[i].status);  // probably missed frame(ptd) in ISP1760 code
#endif
            }
        }
        if (usbhost_enqueueurb(urb) < 0) // error
        {
            usbhost_uvc_stop(drv);
            free(urb->xferbuf);
            free(urb);
        }
    } else
    {
        frame->bufsize = 0;
        free(urb->xferbuf);
        free(urb);
    }
}

/**
 * @brief    Get one MJPEG frame from the video buffer
 *
 * Usual your camera will return a full JPEG frame, but without the
 * huffman table. In this case you should insert that one manually to generate
 * a valid JPEG image. The Altium JPEG decoder core and plugin are able to
 * handle images without Huffman table...
 *
 * @param  drv       UVC driver pointer
 * @param  bufsize   returns the size of the returned buffer
 *
 * @return a pointer to the framebuffer or NULL when empty
 */
uint8_t *usbhost_uvc_get_frame(usbhost_uvc_t *drv, uint32_t *bufsize)
{
    uint8_t  *buf = NULL;

    *bufsize = 0;
    if (drv->ftail != drv->fhead)  // if there are frames
    {
        buf = drv->frame[drv->ftail].buf;
        *bufsize = drv->frame[drv->ftail].bufsize;
        if (drv->ftail == USBHOST_UVC_FBUFSIZE - 1)
           drv->ftail = 0;
        else
           drv->ftail += 1;
    }
    return buf;
}

/**
 * @brief    Stop a started UVC device
 *
 * @param  drv  UVC driver pointer
 *
 * @return Nothing.
 */
void usbhost_uvc_stop(usbhost_uvc_t *drv)
{
    drv->state = USBHOST_UVC_STATE_STOPPED;
}

/**
 * @brief    Start an initialised/stopped UVC device
 *
 * @param  drv  UVC driver pointer
 *
 * @return negative errorvalue or 0 on success
 */
int32_t usbhost_uvc_start(usbhost_uvc_t *drv)
{
    int32_t  npackets;
    uint32_t psize;
    uint8_t  *buf;
    uint32_t buflen;
    int32_t  err = 0;

    drv->fhead = 0;
    drv->ftail = 0;
    // wMaxPacketSize[12..11] = nr of packets per uframe
    // wMaxPacketSize[10..0] = nr of bytes in one packet
    psize = little16(drv->ep->desc.wMaxPacketSize);
    psize = (psize & 0x07ff) * (1 + ((psize >> 11) & 3)); // nr of bytes per uframe

    npackets = 32; // << 3;  // we schedule 8 packets in a single ptd
    buflen = npackets * psize;

    for (int i = 0; i < 2; i++)
    {
        buf = (uint8_t *)malloc(buflen);
        if (buf)
        {
            err = usbhost_doisotransferasync(drv->dev, drv->ep, buf, buflen, usbhost_uvc_video_complete, drv, npackets, psize);
            drv->state = USBHOST_UVC_STATE_STARTED;
        }
        else
        {
            err = -ENOMEM;
        }
    }
    return err;
}

/**
 * @brief    Initialise a connected UVC device
 *
 * Initialise the UVC device to the MJPEG format and a requested framerate.
 * framerate can be anything you like. However common framerates are 30, 15, 10
 * and 5 fps. The actual set framerate is returned.
 *
 * @param  drv  UVC driver pointer
 * @param  fps  requested framerate
 *
 * @return actual framerate or negative value on error
 */
int32_t usbhost_uvc_init(usbhost_uvc_t *drv, int32_t fps)
{
    usbhost_uvc_streaming_control_t ctrl;
    uint16_t                        len;

    usbhost_uvc_docontrolrequest(drv, &len, 10, USBHOST_UVC_GET_LEN, USBHOST_UVC_VS_PROBE_CONTROL);
    len = little16(len);
    ctrl.bmHint = little16(USBHOST_UVC_HINT_FRAME_INTERVAL);
    ctrl.bFormatIndex = drv->mjpegformatindex;
    ctrl.bFrameIndex = drv->mjpegframeindex;
    ctrl.dwFrameInterval = little32(10000000 / fps);
    usbhost_uvc_docontrolrequest(drv, &ctrl, len, USBHOST_UVC_SET_CUR, USBHOST_UVC_VS_PROBE_CONTROL);
    memset(&ctrl, 0, sizeof(usbhost_uvc_streaming_control_t));
    usbhost_uvc_docontrolrequest(drv, &ctrl, len, USBHOST_UVC_GET_CUR, USBHOST_UVC_VS_PROBE_CONTROL);
#if DEBUG_USBHOST_UVC
    usbhost_uvc_print_vc_header_descriptor(&ctrl);
#endif
    drv->fbuflen = little32(ctrl.dwMaxVideoFrameSize);

    usbhost_uvc_docontrolrequest(drv, &ctrl, len, USBHOST_UVC_SET_CUR, USBHOST_UVC_VS_COMMIT_CONTROL);
    usbhost_uvc_set_alternate_interface(drv, drv->sintf, drv->altsetting);

    for(int i = 0; i < USBHOST_UVC_FBUFSIZE; i++)
    {
        drv->frame[i].buf = (uint8_t *)malloc(drv->fbuflen);
        if(!drv->frame[i].buf)
            return -ENOMEM;
    }

    drv->state = USBHOST_UVC_STATE_STOPPED;
    return 10000000 / little32(ctrl.dwFrameInterval);
}

/**
 * @brief    Get the current state of the USB Video Class device driver
 *
 * Query this function to detect a connected UVC device (USBHOST_UVC_STATE_CONNECTED)
 * now you can initialise this UVC device using usbhost_uvc_init(). The driver will
 * now enter the stopped state (USBHOST_UVC_STATE_STOPPED). After this you can safely
 * start and stop the device using usbhost_uvc_start() and usbhost_uvc_stop()
 *
 * @param  drv  UVC driver pointer
 *
 * @return driver state
 */
usbhost_uvc_state_t usbhost_uvc_getstate(usbhost_uvc_t *drv)
{
    return drv->state;
}


/**
 * @brief    Open an instance of the usbhost USB Video Class device service
 *
 * This function initializes the service and opens the driver beneath the first time the function is called.
 * Further attemps to open an already opened instance of the service simply returns the same pointer.
 *
 * @param  id  Valid service id
 *
 * @return Service pointer if succesful initialized
 */
usbhost_uvc_t *usbhost_uvc_open(int id)
{
    assert((id >= 0) && (id < USBHOST_UVC_INSTANCE_COUNT));

    usbhost_uvc_t *restrict drv = &usbhost_uvc_driver_table[id];
    const usbhost_uvc_cfg_instance_t *restrict drv_cfg = &usbhost_uvc_instance_table[id];
    usbhost_t *usbhost;

    if (drv->usbhost) return drv;

    usbhost = usbhost_open(drv_cfg->usbhost);
    drv->usbhost = usbhost;
    usbhost_registerdevicedriver(usbhost, drv, &usbhost_uvc_connect_test, &usbhost_uvc_disconnect_test);
    drv->state = USBHOST_UVC_STATE_NOTCONNECTED;
    drv->last_frameid = 0xFF;
    drv->mjpegformatindex = 0;
    drv->mjpegframeindex = 0;
    return drv;
}

/* TODO: set and get controls (brightness, contrast, hue, etc.) of the processing unit in the UVC device
void usbhost_uvc_set_pucontrol(usbhost_uvc_t *drv, uint8_t pucontrol, int32_t val)
{
    if ((drv->puctrls[1][pucontrol] < val) && (val < drv->puctrls[2][pucontrol]))
    {
        usbhost_uvc_docontrolrequest(drv, &val, 2, USBHOST_UVC_SET_CUR, pucontrol);
        usbhost_uvc_docontrolrequest(drv, &drv->puctrls[0][pucontrol], 2, USBHOST_UVC_GET_CUR, pucontrol);
    }
}

int32_t usbhost_uvc_get_pucontrol(usbhost_uvc_t *drv, uint8_t pucontrol, int i)
{
    switch (pucontrol)
    {
    case USBHOST_UVC_PU_BRIGHTNESS_CONTROL:
    case USBHOST_UVC_PU_HUE_CONTROL:
        return (int16_t)drv->puctrls[i][pucontrol];
    default:
        return drv->puctrls[i][pucontrol];
    }
}

static uint8_t usbhost_uvc_find_pucontrols(usbhost_uvc_t *drv)
{
    usbhost_host_interface_t    *cintf = drv->cintf->curIntf;
    uint8_t                     *rawdesc = cintf->extra;
    uint16_t                    pucontrols;

    while (rawdesc < cintf->extra + cintf->extralen)
    {
        if (((usbhost_csdescriptorheader_t *)rawdesc)->bDescriptorType == USBHOST_DT_CS_INTERFACE)
        {
            switch (((usbhost_csdescriptorheader_t *)rawdesc)->bDescriptorSubtype)
            {
            case USBHOST_UVC_VC_HEADER:
                break;
            case USBHOST_UVC_VC_PROCESSING_UNIT:
                pucontrols = ((usbhost_uvc_processing_unit_descriptor_t *)rawdesc)->bmControls[1] << 8 +
                             ((usbhost_uvc_processing_unit_descriptor_t *)rawdesc)->bmControls[0];
                break;
            default:;
            }
        }
        rawdesc += ((usbhost_csdescriptorheader_t *)rawdesc)->bLength;
    }
    for (uint8_t i = USBHOST_UVC_PU_BACKLIGHT_COMPENSATION_CONTROL; i <= USBHOST_UVC_PU_ANALOG_LOCK_STATUS_CONTROL; i++)
    {
        usbhost_uvc_docontrolrequest(drv, &drv->puctrls[0][i], 2, USBHOST_UVC_GET_CUR, i);
//        usbhost_uvc_docontrolrequest(drv, &drv->puctrls[1][i], 2, USBHOST_UVC_GET_MIN, i);
     //   usbhost_uvc_docontrolrequest(drv, drv->puctrls[2][i], 2, USBHOST_UVC_GET_DEF, i);
       // usbhost_uvc_docontrolrequest(drv, drv->puctrls[3][i], 2, USBHOST_UVC_GET_MAX, i);
    }

    return 0;
}*/





