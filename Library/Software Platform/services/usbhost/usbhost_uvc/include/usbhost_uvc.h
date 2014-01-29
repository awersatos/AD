/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2009, Altium
|*
|*  Description:        USB-Host Video Class Device (UVC) driver
|*
 *****************************************************************************/

/**
 * @file
 *      Driver for USB-Host UVC
 */

#ifndef _DRV_USBHOST_UVC_H
#define _DRV_USBHOST_UVC_H

#include <stdint.h>
#include <stdbool.h>

#ifdef  __cplusplus
extern "C" {
#endif

#include <usbhost.h>
#include <usbhost_core.h>

typedef struct usbhost_uvc_s usbhost_uvc_t;

/**
  * @brief UVC Driver state
  *
  * State of the UVC driver
  */
typedef enum
{
    USBHOST_UVC_STATE_NOTCONNECTED = 0,       /**< No UVC Device Connected */
    USBHOST_UVC_STATE_CONNECTED    = 1,       /**< UVC Device Connected */
    USBHOST_UVC_STATE_STOPPED      = 2,       /**< UVC Device Stopped (Not initialised yet) */
    USBHOST_UVC_STATE_STARTED      = 3,       /**< UVC Device Running */
    USBHOST_UVC_STATE_ACTIVE       = 4,       /**< UVC Device Running (Decoder Active) */
    USBHOST_UVC_STATE_DONE         = 5,       /**< UVC Device Running (Decoder Frame Done) */
    USBHOST_UVC_STATE_ERROR        = 6,       /**< UVC Device Running (Decoder Frame Error) */
} usbhost_uvc_state_t;

// Video Interface Subclass Codes
#define USBHOST_UVC_SC_UNDEFINED                                0x00
#define USBHOST_UVC_SC_VIDEOCONTROL                             0x01
#define USBHOST_UVC_SC_VIDEOSTREAMING                           0x02
#define USBHOST_UVC_SC_VIDEO_INTERFACE_COLLECTION               0x03

// Video Interface Protocol Codes
#define USBHOST_UVC_PC_PROTOCOL_UNDEFINED                       0x00

// Video Class-Specific VC Interface Descriptor Subtypes
#define USBHOST_UVC_VC_DESCRIPTOR_UNDEFINED                     0x00
#define USBHOST_UVC_VC_HEADER                                   0x01
#define USBHOST_UVC_VC_INPUT_TERMINAL                           0x02
#define USBHOST_UVC_VC_OUTPUT_TERMINAL                          0x03
#define USBHOST_UVC_VC_SELECTOR_UNIT                            0x04
#define USBHOST_UVC_VC_PROCESSING_UNIT                          0x05
#define USBHOST_UVC_VC_EXTENSION_UNIT                           0x06

// Video Class-Specific VS Interface Descriptor Subtypes
#define USBHOST_UVC_VS_UNDEFINED                                0x00
#define USBHOST_UVC_VS_INPUT_HEADER                             0x01
#define USBHOST_UVC_VS_OUTPUT_HEADER                            0x02
#define USBHOST_UVC_VS_STILL_IMAGE_FRAME                        0x03
#define USBHOST_UVC_VS_FORMAT_UNCOMPRESSED                      0x04
#define USBHOST_UVC_VS_FRAME_UNCOMPRESSED                       0x05
#define USBHOST_UVC_VS_FORMAT_MJPEG                             0x06
#define USBHOST_UVC_VS_FRAME_MJPEG                              0x07
#define USBHOST_UVC_VS_FORMAT_MPEG2TS                           0x0A
#define USBHOST_UVC_VS_FORMAT_DV                                0x0C
#define USBHOST_UVC_VS_COLORFORMAT                              0x0D
#define USBHOST_UVC_VS_FORMAT_FRAME_BASED                       0x10
#define USBHOST_UVC_VS_FRAME_FRAME_BASED                        0x11
#define USBHOST_UVC_VS_FORMAT_STREAM_BASED                      0x12

// Video Class-Specific Endpoint Descriptor Subtypes
#define USBHOST_UVC_EP_UNDEFINED                                0x00
#define USBHOST_UVC_EP_GENERAL                                  0x01
#define USBHOST_UVC_EP_ENDPOINT                                 0x02
#define USBHOST_UVC_EP_INTERRUPT                                0x03

// Video Class-Specific Request Codes
#define USBHOST_UVC_RC_UNDEFINED                                0x00
#define USBHOST_UVC_SET_CUR                                     0x01
#define USBHOST_UVC_GET_CUR                                     0x81
#define USBHOST_UVC_GET_MIN                                     0x82
#define USBHOST_UVC_GET_MAX                                     0x83
#define USBHOST_UVC_GET_RES                                     0x84
#define USBHOST_UVC_GET_LEN                                     0x85
#define USBHOST_UVC_GET_INFO                                    0x86
#define USBHOST_UVC_GET_DEF                                     0x87

// VideoControl Interface Control Selectors
#define USBHOST_UVC_VC_CONTROL_UNDEFINED                        0x00
#define USBHOST_UVC_VC_VIDEO_POWER_MODE_CONTROL                 0x01
#define USBHOST_UVC_VC_REQUEST_ERROR_CODE_CONTROL               0x02

// Terminal Control Selectors
#define USBHOST_UVC_TE_CONTROL_UNDEFINED                        0x00

// Selector Unit Control Selectors
#define USBHOST_UVC_SU_CONTROL_UNDEFINED                        0x00
#define USBHOST_UVC_SU_INPUT_SELECT_CONTROL                     0x01

// Camera Terminal Control Selectors
#define USBHOST_UVC_CT_CONTROL_UNDEFINED                        0x00
#define USBHOST_UVC_CT_SCANNING_MODE_CONTROL                    0x01
#define USBHOST_UVC_CT_AE_MODE_CONTROL                          0x02
#define USBHOST_UVC_CT_AE_PRIORITY_CONTROL                      0x03
#define USBHOST_UVC_CT_EXPOSURE_TIME_ABSOLUTE_CONTROL           0x04
#define USBHOST_UVC_CT_EXPOSURE_TIME_RELATIVE_CONTROL           0x05
#define USBHOST_UVC_CT_FOCUS_ABSOLUTE_CONTROL                   0x06
#define USBHOST_UVC_CT_FOCUS_RELATIVE_CONTROL                   0x07
#define USBHOST_UVC_CT_FOCUS_AUTO_CONTROL                       0x08
#define USBHOST_UVC_CT_IRIS_ABSOLUTE_CONTROL                    0x09
#define USBHOST_UVC_CT_IRIS_RELATIVE_CONTROL                    0x0A
#define USBHOST_UVC_CT_ZOOM_ABSOLUTE_CONTROL                    0x0B
#define USBHOST_UVC_CT_ZOOM_RELATIVE_CONTROL                    0x0C
#define USBHOST_UVC_CT_PANTILT_ABSOLUTE_CONTROL                 0x0D
#define USBHOST_UVC_CT_PANTILT_RELATIVE_CONTROL                 0x0E
#define USBHOST_UVC_CT_ROLL_ABSOLUTE_CONTROL                    0x0F
#define USBHOST_UVC_CT_ROLL_RELATIVE_CONTROL                    0x10
#define USBHOST_UVC_CT_PRIVACY_CONTROL                          0x11

// Processing Unit Control Selectors
#define USBHOST_UVC_PU_CONTROL_UNDEFINED                        0x00
#define USBHOST_UVC_PU_BACKLIGHT_COMPENSATION_CONTROL           0x01
#define USBHOST_UVC_PU_BRIGHTNESS_CONTROL                       0x02
#define USBHOST_UVC_PU_CONTRAST_CONTROL                         0x03
#define USBHOST_UVC_PU_GAIN_CONTROL                             0x04
#define USBHOST_UVC_PU_POWER_LINE_FREQUENCY_CONTROL             0x05
#define USBHOST_UVC_PU_HUE_CONTROL                              0x06
#define USBHOST_UVC_PU_SATURATION_CONTROL                       0x07
#define USBHOST_UVC_PU_SHARPNESS_CONTROL                        0x08
#define USBHOST_UVC_PU_GAMMA_CONTROL                            0x09
#define USBHOST_UVC_PU_WHITE_BALANCE_TEMPERATURE_CONTROL        0x0A
#define USBHOST_UVC_PU_WHITE_BALANCE_TEMPERATURE_AUTO_CONTROL   0x0B
#define USBHOST_UVC_PU_WHITE_BALANCE_COMPONENT_CONTROL          0x0C
#define USBHOST_UVC_PU_WHITE_BALANCE_COMPONENT_AUTO_CONTROL     0x0D
#define USBHOST_UVC_PU_DIGITAL_MULTIPLIER_CONTROL               0x0E
#define USBHOST_UVC_PU_DIGITAL_MULTIPLIER_LIMIT_CONTROL         0x0F
#define USBHOST_UVC_PU_HUE_AUTO_CONTROL                         0x10
#define USBHOST_UVC_PU_ANALOG_VIDEO_STANDARD_CONTROL            0x11
#define USBHOST_UVC_PU_ANALOG_LOCK_STATUS_CONTROL               0x12

// Extension Unit Control Selectors
#define USBHOST_UVC_XU_CONTROL_UNDEFINED                        0x00

// VideoStreaming Interface Control Selectors
#define USBHOST_UVC_VS_CONTROL_UNDEFINED                        0x00
#define USBHOST_UVC_VS_PROBE_CONTROL                            0x01
#define USBHOST_UVC_VS_COMMIT_CONTROL                           0x02
#define USBHOST_UVC_VS_STILL_PROBE_CONTROL                      0x03
#define USBHOST_UVC_VS_STILL_COMMIT_CONTROL                     0x04
#define USBHOST_UVC_VS_STILL_IMAGE_TRIGGER_CONTROL              0x05
#define USBHOST_UVC_VS_STREAM_ERROR_CODE_CONTROL                0x06
#define USBHOST_UVC_VS_GENERATE_KEY_FRAME_CONTROL               0x07
#define USBHOST_UVC_VS_UPDATE_FRAME_SEGMENT_CONTROL             0x08
#define USBHOST_UVC_VS_SYNCH_DELAY_CONTROL                      0x09

// USB Terminal Types
#define USBHOST_UVC_TT_VENDOR_SPECIFIC                          0x0100
#define USBHOST_UVC_TT_STREAMING                                0x0101

// Input Terminal Types
#define USBHOST_UVC_ITT_VENDOR_SPECIFIC                         0x0200
#define USBHOST_UVC_ITT_CAMERA                                  0x0201
#define USBHOST_UVC_ITT_MEDIA_TRANSPORT_INPUT                   0x0202

// Output Terminal Types
#define USBHOST_UVC_OTT_VENDOR_SPECIFIC                         0x0300
#define USBHOST_UVC_OTT_DISPLAY                                 0x0301
#define USBHOST_UVC_OTT_MEDIA_TRANSPORT_OUTPUT                  0x0302


// This is the standard GUID / UUID.
typedef struct __packed__ {
    uint32_t    data1;
    uint16_t    data2;
    uint16_t    data3;
    uint8_t     data4[8];
} usbhost_uvc_guid_t;


// Class-specific Video Control Interface Header Descriptor
typedef struct __packed__ {
    uint8_t     bLength;
    uint8_t     bDescriptorType;
    uint8_t     bDescriptorSubtype;
    uint16_t    bcdUVC;
    uint16_t    wTotalLength;
    uint32_t    dwClockFrequency;
    uint8_t     bInCollection;
    // followed by n bytes where n is equal to value of bInCollection
    uint8_t     baInterfaceNr[];
} usbhost_uvc_vc_header_descriptor_t;

// Input Terminal Descriptor
typedef struct __packed__ {
    uint8_t     bLength;
    uint8_t     bDescriptorType;
    uint8_t     bDescriptorSubtype;
    uint8_t     bTerminalID;
    uint16_t    wTerminalType;
    uint8_t     bAssocTerminal;
    uint8_t     iTerminal;
    // possibly more, depending on Terminal type
} usbhost_uvc_input_terminal_descriptor_t;

// Output Terminal Descriptor
typedef struct __packed__ {
    uint8_t     bLength;
    uint8_t     bDescriptorType;
    uint8_t     bDescriptorSubtype;
    uint8_t     bTerminalID;
    uint16_t    wTerminalType;
    uint8_t     bAssocTerminal;
    uint8_t     bSourceID;
    uint8_t     iTerminal;
} usbhost_uvc_output_terminal_descriptor_t;

// Camera Terminal Descriptor
typedef struct __packed__ {
    uint8_t     bLength;
    uint8_t     bDescriptorType;
    uint8_t     bDescriptorSubtype;     // USBHOST_UVC_VC_INPUT_TERMINAL
    uint8_t     bTerminalID;
    uint16_t    wTerminalType;      // USBHOST_UVC_ITT_CAMERA
    uint8_t     bAssocTerminal;
    uint8_t     iTerminal;
    uint16_t    wObjectiveFocalLengthMin;
    uint16_t    wObjectiveFocalLengthMax;
    uint16_t    wOcularFocalLength;
    uint8_t     bControlSize;
    uint8_t     bmControls[];
} usbhost_uvc_camera_terminal_descriptor_t;

// bmControls fields of usbhost_camera_terminal_descriptor_t
#define USBHOST_UVC_CAMERA_CONTROL_SCANNING_MODE                (1<<0)
#define USBHOST_UVC_CAMERA_CONTROL_AUTO_EXPOSURE_MODE           (1<<1)
#define USBHOST_UVC_CAMERA_CONTROL_AUTO_EXPOSURE_PRIO           (1<<2)
#define USBHOST_UVC_CAMERA_CONTROL_EXPOSURE_TIME_ABSOLUTE       (1<<3)
#define USBHOST_UVC_CAMERA_CONTROL_EXPOSURE_TIME_RELATIVE       (1<<4)
#define USBHOST_UVC_CAMERA_CONTROL_FOCUS_ABSOLUTE               (1<<5)
#define USBHOST_UVC_CAMERA_CONTROL_FOCUS_RELATIVE               (1<<6)
#define USBHOST_UVC_CAMERA_CONTROL_IRIS_ABSOLUTE                (1<<7)
#define USBHOST_UVC_CAMERA_CONTROL_IRIS_RELATIVE                (1<<8)
#define USBHOST_UVC_CAMERA_CONTROL_ZOOM_ABSOLUTE                (1<<9)
#define USBHOST_UVC_CAMERA_CONTROL_ZOOM_RELATIVE                (1<<10)
#define USBHOST_UVC_CAMERA_CONTROL_PANTILT_ABSOLUTE             (1<<11)
#define USBHOST_UVC_CAMERA_CONTROL_PANTILT_RELATIVE             (1<<12)
#define USBHOST_UVC_CAMERA_CONTROL_ROLL_ABSOLUTE                (1<<13)
#define USBHOST_UVC_CAMERA_CONTROL_ROLL_RELATIVE                (1<<14)
// 15,16 reserved
#define USBHOST_UVC_CAMERA_CONTROL_FOCUS_AUTO                   (1<<17)
#define USBHOST_UVC_CAMERA_CONTROL_PRIVACY                      (1<<18)

typedef struct __packed__ {
    uint8_t     bLength;
    uint8_t     bDescriptorType;
    uint8_t     bDescriptorSubtype;
    uint8_t     bUnitID;
    uint8_t     bNrInPins;
    uint8_t     baSourceID[];
    /* The position of the next field is baSourceID[0] + bNrInPins
     * and should be accessed via a function. */
//      uint8_t           iSelector
} usbhost_uvc_selector_unit_descriptor_t;

typedef struct __packed__ {
    uint8_t     bLength;
    uint8_t     bDescriptorType;
    uint8_t     bDescriptorSubtype;
    uint8_t     bUnitID;
    uint8_t     bSourceID;
    uint16_t    wMaxMultiplier;
    uint8_t     bControlSize;
    uint8_t     bmControls[];
//      uint8_t           iProcessing
//      uint8_t           bmVideoStandards
#define PU_GET_VIDEO_STANDARDS(desc)   (*((desc)->bmControls + (desc)->bControlSize))
#define USBHOST_UVC_STANDARD_NONE                               (1<<0)
#define USBHOST_UVC_STANDARD_NTSC_525_60                        (1<<1)
#define USBHOST_UVC_STANDARD_PAL_625_50                         (1<<2)
#define USBHOST_UVC_STANDARD_SECAM_625_50                       (1<<3)
#define USBHOST_UVC_STANDARD_NTSC_625_50                        (1<<4)
#define USBHOST_UVC_STANDARD_PAL_525_60                         (1<<5)
} usbhost_uvc_processing_unit_descriptor_t;

typedef struct __packed__ {
    uint8_t     bLength;
    uint8_t     bDescriptorType;
    uint8_t     bDescriptorSubtype;
    uint8_t     bUnitID;
    usbhost_uvc_guid_t  guidExtensionCode;
    uint8_t     bNumControls;
    uint8_t     bNrInPins;
    uint8_t     baSourceID[];
//      uint8_t           bControlSize
//      uint8_t           bmControls
#define XU_GET_CONTROL_SIZE(desc)  (*((desc)->baSourceID + (desc)->bNrInPins))
#define XU_GET_CONTROLS(desc)      ((desc)->baSourceID + (desc)->bNrInPins + 1)
//      uint8_t           iExtension
} usbhost_uvc_extension_unit_descriptor_t;

typedef struct __packed__ {
    uint8_t     bLength;
    uint8_t     bDescriptorType;
    uint8_t     bDescriptorSubtype;
    uint16_t    wMaxTransferSize;
} usbhost_uvc_vc_interrupt_endpoint_descriptor_t;


// Copy protection state
#define USBHOST_UVC_NO_RESTRICTIONS                             0
#define USBHOST_UVC_RESTRICT_DUP                                1

typedef struct __packed__ {
    uint8_t     bLength;
    uint8_t     bDescriptorType;
    uint8_t     bDescriptorSubtype;
    uint8_t     bNumFormats;
    uint16_t    wTotalLength;
    uint8_t     bEndpointAddress;
    uint8_t     bmInfo;
    uint8_t     bTerminalLink;
    uint8_t     bStillCaptureMethod;
    uint8_t     bTriggerSupport;
    uint8_t     bTriggerUsage;
    uint8_t     bControlSize;
    uint8_t     bmaControls[];
#define USBHOST_UVC_VS_KEYFRAME_RATE                            (1<<0)
#define USBHOST_UVC_VS_PFRAME_RATE                              (1<<1)
#define USBHOST_UVC_VS_COMP_QUALITY                             (1<<2)
#define USBHOST_UVC_VS_COMP_WINDOW_SIZE                         (1<<3)
#define USBHOST_UVC_VS_GENERATE_KEYFRAME                        (1<<4)
#define USBHOST_UVC_VS_UPDATE_FRAME_SEGMENT                     (1<<5)
} usbhost_uvc_vs_input_header_descriptor_t;

typedef struct __packed__ {
    uint8_t     bLength;
    uint8_t     bDescriptorType;
    uint8_t     bDescriptorSubtype;
    uint8_t     bNumFormats;
    uint16_t    wTotalLength;
    uint8_t     bEndpointAddress;
    uint8_t     bTerminalLink;
    uint8_t     bControlSize;
    uint8_t     bmaControls[];
} usbhost_uvc_vs_output_header_descriptor_t;


typedef struct __packed__ {
    uint16_t    wWidth;
    uint16_t    wHeight;
} usbhost_uvc_still_image_frame_dimensions_t;

typedef struct __packed__ {
    uint8_t     bLength;
    uint8_t     bDescriptorType;
    uint8_t     bDescriptorSubtype;
    uint8_t     bEndpointAddress;
    uint8_t     bNumImageSizePatterns;
    usbhost_uvc_still_image_frame_dimensions_t wwaDimensions[];
    // position dependent on size of previous item
    // uint8_t  bNumCompressionPattern
    // uint8_t  bCompression[]
} usbhost_uvc_still_image_frame_descriptor_t;


// Color matching information
// bColroPrimaries
#define USBHOST_UVC_COLOR_PRIMARIES_UNSPECIFIED                 0
#define USBHOST_UVC_COLOR_PRIMARIES_sRGB                        1 // same as BT709
#define USBHOST_UVC_COLOR_PRIMARIES_BT709                       1 // default
#define USBHOST_UVC_COLOR_PRIMARIES_BT470_2_M                   2
#define USBHOST_UVC_COLOR_PRIMARIES_BT470_2_BG                  3
#define USBHOST_UVC_COLOR_PRIMARIES_SMPTE_170M                  4
#define USBHOST_UVC_COLOR_PRIMARIES_SMPTE_240M                  5

// bTransferCharacteristics
#define USBHOST_UVC_GAMMA_FUNCTION_UNSPECIFIED                  0
#define USBHOST_UVC_GAMMA_FUNCTION_BT709                        1 // default
#define USBHOST_UVC_GAMMA_FUNCTION_BT470_2_M                    2
#define USBHOST_UVC_GAMMA_FUNCTION_BT470_2_BG                   3
#define USBHOST_UVC_GAMMA_FUNCTION_SMPTE_170M                   4
#define USBHOST_UVC_GAMMA_FUNCTION_SMPTE_240M                   5
#define USBHOST_UVC_GAMMA_FUNCTION_LINEAR                       6
#define USBHOST_UVC_GAMMA_FUNCTION_sRGB                         7 // similar to BT709

// bMatrixCoefficients
#define USBHOST_UVC_LUMA_CHROMA_MATRIX_UNSPECIFIED              0
#define USBHOST_UVC_LUMA_CHROMA_MATRIX_BT709                    1
#define USBHOST_UVC_LUMA_CHROMA_MATRIX_FCC                      2
#define USBHOST_UVC_LUMA_CHROMA_MATRIX_BT470_2_BG               3
#define USBHOST_UVC_LUMA_CHROMA_MATRIX_SMPTE_170M               4 // default
#define USBHOST_UVC_LUMA_CHROMA_MATRIX_SMPTE_240M               5

typedef struct __packed__ {
    uint8_t     bLength;
    uint8_t     bDescriptorType;
    uint8_t     bDescriptorSubtype;
    uint8_t     bColorPrimaries;
    uint8_t     bTransferCharacteristics;
    uint8_t     bMatrixCoefficients;
} usbhost_uvc_color_matching_descriptor_t;

// Format and Frame descriptors
#define USBHOST_UVC_FRAME_CAP_STILL_IMAGE                       (1<<0)
#define USBHOST_UVC_FRAME_CAP_FIXED_RATE                        (1<<1)

#define USBHOST_UVC_FRAME_INTERVAL_CONTINUOUS                   0

typedef struct __packed__ {
    uint32_t    dwMinFrameInterval;
    uint32_t    dwMaxFrameInterval;
    uint32_t    dwFrameIntervalStep;
} usbhost_uvc_frame_interval_continuous_t;

typedef struct __packed__ {
    uint32_t    dwFrameInterval[1]; // length depends on bFrameIntervalType
} usbhost_uvc_frame_interval_discrete_t;

typedef union {
    usbhost_uvc_frame_interval_continuous_t continuous;
    usbhost_uvc_frame_interval_discrete_t   discrete;
} usbhost_uvc_frame_interval_t;

// generic format descriptor header
typedef struct __packed__ {
    uint8_t     bLength;
    uint8_t     bDescriptorType;
    uint8_t     bDescriptorSubtype;
    uint8_t     bFormatIndex;
} usbhost_uvc_vs_format_descriptor_t;

// generic frame descriptor header
typedef struct __packed__ {
    uint8_t     bLength;
    uint8_t     bDescriptorType;
    uint8_t     bDescriptorSubtype;
    uint8_t     bFrameIndex;
} usbhost_uvc_vs_frame_descriptor_t;

typedef struct __packed__ {
    uint8_t     bLength;
    uint8_t     bDescriptorType;
    uint8_t     bDescriptorSubtype;
    uint8_t     bFormatIndex;
    uint8_t     bNumFrameDescriptors;
    usbhost_uvc_guid_t  guidFormat;
    uint8_t     bBitsPerPixel;
    uint8_t     bDefaultFrameIndex;
    uint8_t     bAspectRatioX;
    uint8_t     bAspectRatioY;
    uint8_t     bmInterlaceFlags;
    uint8_t     bCopyProtect;
} usbhost_uvc_vs_format_uncompressed_descriptor_t;

typedef struct __packed__ {
    uint8_t     bLength;
    uint8_t     bDescriptorType;
    uint8_t     bDescriptorSubtype;
    uint8_t     bFrameIndex;
    uint8_t     bmCapabilities;
    uint16_t    wWidth;
    uint16_t    wHeight;
    uint32_t    dwMinBitRate;
    uint32_t    dwMaxBitRate;
    uint32_t    dwMaxVideoFrameBufferSize;
    uint32_t    dwDefaultFrameInterval;
    uint8_t     bFrameIntervalType;
    usbhost_uvc_frame_interval_t uFrameInterval;
} usbhost_uvc_vs_frame_uncompressed_descriptor_t;


/* Frame based Format and Frame descriptors.  This is for generic
 * frame based payloads not covered by other types (e.g, uncompressed
 * or MJPEG). */
 typedef struct __packed__ {
    uint8_t     bLength;
    uint8_t     bDescriptorType;
    uint8_t     bDescriptorSubtype;
    uint8_t     bFormatIndex;
    uint8_t     bNumFrameDescriptors;
    usbhost_uvc_guid_t  guidFormat;
    uint8_t     bBitsPerPixel;
    uint8_t     bDefaultFrameIndex;
    uint8_t     bAspectRatioX;
    uint8_t     bAspectRatioY;
    uint8_t     bmInterlaceFlags;
    uint8_t     bCopyProtect;
} usbhost_uvc_format_frame_based_descriptor_t;

typedef struct __packed__ {
    uint8_t     bLength;
    uint8_t     bDescriptorType;
    uint8_t     bDescriptorSubtype;
    uint8_t     bFrameIndex;
    uint8_t     bmCapabilities;
    uint16_t    wWidth;
    uint16_t    wHeight;
    uint32_t    dwMinBitRate;
    uint32_t    dwMaxBitRate;
    uint32_t    dwDefaultFrameInterval;
    uint8_t     bFrameIntervalType;
    uint32_t    dwBytesPerLine;
    usbhost_uvc_frame_interval_t uFrameInterval;
} usbhost_uvc_frame_frame_based_descriptor_t;


// MJPEG format and frame descriptors
typedef struct __packed__ {
    uint8_t     bLength;
    uint8_t     bDescriptorType;
    uint8_t     bDescriptorSubtype;
    uint8_t     bFormatIndex;
    uint8_t     bNumFrameDescriptors;
    uint8_t     bmFlags;
#define USBHOST_UVC_NO_FIXED_SIZE_SAMPLES                       0
#define USBHOST_UVC_FIXED_SIZE_SAMPLES                          1
    uint8_t     bDefaultFrameIndex;
    uint8_t     bAspectRatioX;
    uint8_t     bAspectRatioY;
    uint8_t     bmInterlaceFlags;
    uint8_t     bCopyProtect;
} usbhost_uvc_vs_format_mjpeg_descriptor_t;

typedef struct __packed__ {
    uint8_t     bLength;
    uint8_t     bDescriptorType;
    uint8_t     bDescriptorSubtype;
    uint8_t     bFrameIndex;
    uint8_t     bmCapabilities;
    uint16_t    wWidth;
    uint16_t    wHeight;
    uint32_t    dwMinBitRate;
    uint32_t    dwMaxBitRate;
    uint32_t    dwMaxVideoFrameBufferSize;
    uint32_t    dwDefaultFrameInterval;
    uint8_t     bFrameIntervalType;
    usbhost_uvc_frame_interval_t uFrameInterval;
} usbhost_uvc_vs_frame_mjpeg_descriptor_t;


typedef struct __packed__ {
    uint8_t     bLength;
    uint8_t     bDescriptorType;
    uint8_t     bDescriptorSubtype;
    uint8_t     bFormatIndex;
    uint32_t    dwMaxVideoFrameBufferSize;
    uint8_t     bFormatType;
#define USBHOST_UVC_GET_DV_FREQ(b)                 (((b)>>7) & 1)
#define USBHOST_UVC_DV_FORMAT_FREQ_50HZ                         0
#define USBHOST_UVC_DV_FORMAT_FREQ_60HZ                         1
#define USBHOST_UVC_GET_DV_FORMAT(b)                 ((b) & 0x3f)
#define USBHOST_UVC_DV_FORMAT_SD_DV                             0
#define USBHOST_UVC_DV_FORMAT_SDL_DV                            1
#define USBHOST_UVC_DV_FORMAT_HD_DV                             2
} usbhost_uvc_vs_format_dv_descriptor_t;



// Video Control requests

// Pseudo bitmasks that only work when bitwise OR onto a zeroed value
#define USBHOST_UVC_REQUEST_TYPE_INTERFACE                      (0x0001)
#define USBHOST_UVC_REQUEST_TYPE_ENDPOINT                       (0x0010)
#define USBHOST_UVC_REQUEST_TYPE_CLASS_SPECIFIC                 (0x01 << 5)
#define USBHOST_UVC_REQUEST_TYPE_SET                            (0x0 << 7)
#define USBHOST_UVC_REQUEST_TYPE_GET                            (0x1 << 7)


// bitmask result of GET_INFO on a control
#define USBHOST_UVC_CONTROL_INFO_SUPPORTS_GET                   (1<<0)
#define USBHOST_UVC_CONTROL_INFO_SUPPORTS_SET                   (1<<1)
#define USBHOST_UVC_CONTROL_INFO_DISABLED                       (1<<2)
#define USBHOST_UVC_CONTROL_INFO_AUTOUPDATE                     (1<<3)
#define USBHOST_UVC_CONTROL_INFO_ASYNC                          (1<<4)


// Video Probe and Commit Controls to negotiate streaming parameters with device $4.3.3.1 UVC spec.
typedef struct __packed__ {
    uint16_t    bmHint;
#define USBHOST_UVC_HINT_FRAME_INTERVAL                         (1<<0)
#define USBHOST_UVC_HINT_KEYFRAME_RATE                          (1<<1)
#define USBHOST_UVC_HINT_PFRAME_RATE                            (1<<2)
#define USBHOST_UVC_HINT_COMP_QUALITY                           (1<<3)
#define USBHOST_UVC_HINT_COMP_WINDOW_SIZE                       (1<<4)
    uint8_t     bFormatIndex;
    uint8_t     bFrameIndex;
    uint32_t    dwFrameInterval;
#define USBHOST_UVC_100NS_PER_MS                                10000
#define USBHOST_UVC_FRAME_INTERVAL_UNITS_PER_USB_FRAME          USBHOST_UVC_100NS_PER_MS
    uint16_t    wKeyFrameRate;
    uint16_t    wPFrameRate;
    uint16_t    wCompQuality;
    uint16_t    wCompWindowSize;
    uint16_t    wDelay;
    uint32_t    dwMaxVideoFrameSize;
    uint32_t    dwMaxPayloadTransferSize;
    // Following fields are not in v1.0 of UVC
    uint32_t    dwClockFrequency;
    uint8_t     bmFramingInfo;
#define USBHOST_UVC_FRAMING_INFO_FID                            (1<<0)
#define USBHOST_UVC_FRAMING_INFO_EOF                            (1<<1)
    uint8_t     bPreferedVersion;
    uint8_t     bMinVersion;
    uint8_t     bMaxVersion;
} usbhost_uvc_streaming_control_t;

// Video Still Probe and Still Commit Controls request data
typedef struct __packed__ {
    uint8_t     bFormatIndex;
    uint8_t     bFrameIndex;
    uint8_t     bCompressionIndex;
    uint32_t    dwMaxVideoFrameSize;
    uint32_t    dwMaxPayloadTransferSize;
} usbhost_uvc_still_video_control_t;
#define USBHOST_UVC_STILL_PROBE_AND_STILL_COMMIT_DATA_SIZE      11;



// common header for Video Control and Video Stream status
typedef struct __packed__ {
    uint8_t     bStatusType;
#define USBHOST_UVC_STATUS_TYPE_CONTROL                         0x02
#define USBHOST_UVC_STATUS_TYPE_STREAM                          0x04
    uint8_t     bOriginator;
} usbhost_uvc_status_t;

typedef struct __packed__ {
    uint8_t     bStatusType;
    uint8_t     bOriginator;
    uint8_t     bEvent;
#define USBHOST_UVC_CONTROL_CHANGE                              0x00 // any other value is Reserved
    uint8_t     bSelector;
    uint8_t     bAttribute;
#define USBHOST_UVC_CONTROL_VALUE_CHANGE                        0x00
#define USBHOST_UVC_CONTROL_INFO_CHANGE                         0x01
#define USBHOST_UVC_CONTROL_FAILURE_CHANGE                      0x02
    uint8_t     bValue;
} usbhost_uvc_control_status_t;

typedef struct __packed__ {
    uint8_t     bStatusType;
    uint8_t     bOriginator;
    uint8_t     bEvent;
#define USBHOST_UVC_BUTTON_PRESS                                0x00 // any other value is Stream Error
    uint8_t     bValue;
#define USBHOST_UVC_BUTTON_RELEASED                             0x00
#define USBHOST_UVC_BUTTON_PRESSED                              0x01
} usbhost_uvc_streaming_status_t;

typedef struct __packed__ {
    uint8_t     bHeaderLength;
    uint8_t     bmHeaderInfo;
#define USBHOST_UVC_FRAME_ID                                    (1<<0)
#define USBHOST_UVC_END_OF_FRAME                                (1<<1)
#define USBHOST_UVC_PRES_TIME                                   (1<<2)
#define USBHOST_UVC_SRC_CLOCK                                   (1<<3)
#define USBHOST_UVC_STILL_IMAGE                                 (1<<5)
#define USBHOST_UVC_STREAM_ERROR                                (1<<6)
#define USBHOST_UVC_END_OF_HDR                                  (1<<7)
// other fields depend on which bits are set above and have no fixed offset
//  uint32_t    dwPresentationTime;
#define USBHOST_UVC_PTS_SIZE                                    4
//  uint8_t     scrSourceClock[USBHOST_UVC_SOURCE_CLOCK_SIZE];
#define USBHOST_UVC_SOURCE_CLOCK_SIZE                           6
#define USBHOST_UVC_GET_SOURCE_TIME_CLOCK(sc)                  (UGETDW(sc))
// bits 42..32
#define UV_GET_SOF_COUNTER(sc)                  (((sc)[4] | ((sc)[5] << 8)) &0x7ff)
} usbhost_uvc_payload_header_t;

extern uint8_t *usbhost_uvc_get_frame(usbhost_uvc_t *drv, uint32_t *bufsize);
extern void usbhost_uvc_stop(usbhost_uvc_t *drv);
extern int32_t usbhost_uvc_start(usbhost_uvc_t *drv);
extern int32_t usbhost_uvc_init(usbhost_uvc_t *drv, int32_t fps);
extern usbhost_uvc_state_t usbhost_uvc_getstate(usbhost_uvc_t *drv);
extern usbhost_uvc_t *usbhost_uvc_open(int id);

#ifdef  __cplusplus
}
#endif

#endif /* _DRV_USBHOST_UVC_H */
