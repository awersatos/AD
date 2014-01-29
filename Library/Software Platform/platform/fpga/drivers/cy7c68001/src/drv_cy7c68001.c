/*
 * USB handling
 */

#include <assert.h>
#include <drv_cy7c68001.h>

#include <util_endian.h>

#include <interrupts.h>
#include <per_cy7c68001.h>

#include <drv_cy7c68001_cfg.h>
#include <drv_cy7c68001_cfg_instance.h>

/* common defines for USB */
#define USB_ENDPOINT(x)         ((x) & 0x7F)
#define MAX_EP_COUNT            5               /* EP: 0, 2, 4, 6, 8 */

struct _usb_t {
    cy7c68001_t                     *per;
    int                             ep_packet_size[MAX_EP_COUNT];
    usb_setup_t                     usb_setup;
    uint8_t                         ep0_buffer[USB_EP0_BUFFER_SIZE];
    int                             ep0_length;
    usb_class_request_handler_t     *class_request_func;
    void                            *class_request_func_data;
};

static struct _usb_t drv_table[DRV_CY7C68001_INSTANCE_COUNT];


/* get endpoint buffer size using lookup table */
static int get_ep_packet_size(usb_t *usb, uint8_t endpoint)
{
    int     size = 0;

    switch (USB_ENDPOINT(endpoint))
    {
        case 0:
            size = usb->ep_packet_size[0];
            break;
        case 2:
            size = usb->ep_packet_size[1];
            break;
        case 4:
            size = usb->ep_packet_size[2];
            break;
        case 6:
            size = usb->ep_packet_size[3];
            break;
        case 8:
            size = usb->ep_packet_size[4];
            break;
        default:
            /* not handled */
            break;
    }
    return size;
}

/**
 * @brief	Initialize USB device
 *
 * This function sets initial values for the USB device.
 *
 * @param	id					Device id (defined in devices.h)
 * @param	descriptor			device descriptor
 * @param	descriptor_length	length of descriptor
 *
 * @return	USB driver pointer if successful, or NULL otherwise.
 */
usb_t *usb_open(int id, uint8_t *descriptor, int descriptor_length)
{
    usb_t *usb;
    const drv_cy7c68001_cfg_instance_t *drv_cfg;

    assert((id >= 0) && (id < DRV_CY7C68001_INSTANCE_COUNT));

    usb = &drv_table[id];
    
    if (usb->per == NULL)
    {
        drv_cfg = &drv_cy7c68001_instance_table[id];

        /* initialize USB driver */
        usb->per = cy7c68001_open(drv_cfg->per_cy7c68001);
        if (usb->per != NULL)
        {
            usb_init(usb->per, descriptor_length, descriptor);

            /* set USB packet length */
            usb_set_packet_size(usb, 0, USB_EP0_BUFFER_SIZE);
            usb_set_packet_size(usb, 2, USB_EPx_BUFFER_SIZE);
            usb_set_packet_size(usb, 4, USB_EPx_BUFFER_SIZE);
            usb_set_packet_size(usb, 6, USB_EPx_BUFFER_SIZE);
            usb_set_packet_size(usb, 8, USB_EPx_BUFFER_SIZE);

            /* do not send zero-length packets */
            usb_clear_register_bit(usb->per, EP6PKTLENH, 5);
            usb_clear_register_bit(usb->per, EP8PKTLENH, 5);
        }
    }
    return usb->per == NULL ? NULL : usb;
}

/**
 * @brief	Set class request handler function
 *
 * @param	usb		usb driver pointer
 * @param	func	class request handler function
 * @param	data	data to pass to func when called
 *
 * @return	none
 */
void usb_set_class_request_handler(usb_t *usb, usb_class_request_handler_t* func, void *data)
{
    usb->class_request_func = func;
    usb->class_request_func_data = data;
}

/**
 * @brief	Set USB packet size for an endpoint
 *
 * @param	usb			usb driver pointer
 * @param	endpoint	number of endpoint to set packet size for
 * @param	packet_size	packet size for the specified endpoint
 *
 * @return	none
 */
void usb_set_packet_size(usb_t *usb, uint8_t endpoint, int packet_size)
{
    unsigned short  pktlen_low  = (packet_size & 0xFF);
    unsigned short  pktlen_high = ((packet_size >> 8) & 0x07);

    switch (USB_ENDPOINT(endpoint))
    {
        case 0:
            usb->ep_packet_size[0] = packet_size;
            break;
        case 2:
            usb_set_register_bitmask(usb->per, EP2PKTLENL, 0xFF, pktlen_low);
            usb_set_register_bitmask(usb->per, EP2PKTLENH, 0x07, pktlen_high);
            usb->ep_packet_size[1] = packet_size;
            break;
        case 4:
            pktlen_high &= 0x03;
            usb_set_register_bitmask(usb->per, EP4PKTLENL, 0xFF, pktlen_low);
            usb_set_register_bitmask(usb->per, EP4PKTLENH, 0x03, pktlen_high);
            usb->ep_packet_size[2] = packet_size;
            break;
        case 6:
            usb_set_register_bitmask(usb->per, EP6PKTLENL, 0xFF, pktlen_low);
            usb_set_register_bitmask(usb->per, EP6PKTLENH, 0x07, pktlen_high);
            usb->ep_packet_size[3] = packet_size;
            break;
        case 8:
            pktlen_high &= 0x03;
            usb_set_register_bitmask(usb->per, EP8PKTLENL, 0xFF, pktlen_low);
            usb_set_register_bitmask(usb->per, EP8PKTLENH, 0x03, pktlen_high);
            usb->ep_packet_size[4] = packet_size;
            break;
        default:
            /* not handled */
            break;
    }
}

/**
 * @brief	Get packet size of an endpoint
 *
 * @param	usb			usb driver pointer
 * @param	endpoint	number of endpoint to get packet size of
 *
 * @return	packet size of the specified endpoint
 */
int usb_get_packet_size(usb_t *usb, uint8_t endpoint)
{
    int     size = 0;

    if (usb_endpoint_is_valid(usb, endpoint))
    {
        size = get_ep_packet_size(usb, endpoint);
        if (size == 0)
        {
            unsigned short  pktlen_low, pktlen_high;

            switch (USB_ENDPOINT(endpoint))
            {
                case 0:
                    size = 64;
                    usb->ep_packet_size[0] = size;
                    break;
                case 2:
                    pktlen_low  = usb_read_register(usb->per, EP2PKTLENL);
                    pktlen_high = usb_read_register(usb->per, EP2PKTLENH);
                    size = (pktlen_high << 8) | pktlen_low;
                    usb->ep_packet_size[1] = size;
                    break;
                case 4:
                    pktlen_low  = usb_read_register(usb->per, EP4PKTLENL);
                    pktlen_high = usb_read_register(usb->per, EP4PKTLENH);
                    size = (pktlen_high << 8) | pktlen_low;
                    usb->ep_packet_size[2] = size;
                    break;
                case 6:
                    pktlen_low  = usb_read_register(usb->per, EP6PKTLENL);
                    pktlen_high = usb_read_register(usb->per, EP6PKTLENH);
                    size = (pktlen_high << 8) | pktlen_low;
                    usb->ep_packet_size[3] = size;
                    break;
                case 8:
                    pktlen_low  = usb_read_register(usb->per, EP8PKTLENL);
                    pktlen_high = usb_read_register(usb->per, EP8PKTLENH);
                    size = (pktlen_high << 8) | pktlen_low;
                    usb->ep_packet_size[4] = size;
                    break;
                default:
                    /* not handled */
                    break;
            }
        }
    }
    return size;
}

/* static support functions for USB setup reading */
static uint8_t usb_read_setup_byte(usb_t *usb)
{
    return (uint8_t) usb_read_register(usb->per, SETUP);
}

static uint16_t usb_read_setup_word(usb_t *usb)
{
    uint16_t    word;

    word   = usb_read_setup_byte(usb);
    word <<= 8;
    word  |= usb_read_setup_byte(usb);
    return little16(word);
}

/**
 * @brief Read setup packet (to driver internal data)
 *
 * @param	usb		usb driver pointer
 *
 * @return	number of bytes read
 */
int usb_read_setup(usb_t *usb)
{
    usb->usb_setup.bmRequestType = usb_read_setup_byte(usb);
    usb->usb_setup.bRequest      = usb_read_setup_byte(usb);
    usb->usb_setup.wValue        = usb_read_setup_word(usb);
    usb->usb_setup.wIndex        = usb_read_setup_word(usb);
    usb->usb_setup.wLength       = usb_read_setup_word(usb);
    return 8; /* number of bytes read */
}

/* handle USB standard requests */
static bool usb_handle_standard_request(usb_t *usb /*usb_setup_t* setup*/)
{
    bool    stall_request = true;
    uint8_t endpoint;

    switch (USB_REQTYPE_GET_RECIP(&usb->usb_setup))
    {
        case USB_REQTYPE_RECIP_ENDPOINT:
            endpoint = USB_SETUP_GET_ENDPOINT(&usb->usb_setup);
            switch (USB_REQTYPE_GET_REQUEST(&usb->usb_setup))
            {
                case USB_REQ_CLEAR_FEATURE:
                    usb_unstall_endpoint(usb, endpoint);
                    stall_request = false;
                    break;
                case USB_REQ_SET_FEATURE:
                    usb_stall_endpoint(usb, endpoint);
                    stall_request = false;
                    break;
                default:
                    /* not handled => stall request */
                    break;
            }
            break;
        case USB_REQTYPE_RECIP_DEVICE:
        case USB_REQTYPE_RECIP_INTERFACE:
        default:
            /* not handled => stall request */
            break;
    }
    return stall_request;
}

/* handle USB setup requests */
static void usb_handle_setup_request(usb_t *usb)
{
    bool    stall_request = false;

    usb_set_got_setup(usb->per, false);

    usb_read_setup(usb);
    switch (USB_REQTYPE_GET_TYPE(&usb->usb_setup))
    {
        case USB_REQTYPE_TYPE_STANDARD:
            stall_request = usb_handle_standard_request(usb);
            break;
        case USB_REQTYPE_TYPE_CLASS:
            if (usb->class_request_func != NULL)
            {
                stall_request = usb->class_request_func(&usb->usb_setup, usb->ep0_buffer, &usb->ep0_length, usb->class_request_func_data);
            }
            else
            {
                stall_request = true;
            }
            break;
        case USB_REQTYPE_TYPE_VENDOR:
        case USB_REQTYPE_TYPE_RESERVED:
        default:
            stall_request = true;
            break;
    }
    if (stall_request)
    {
        usb_write_register(usb->per, SETUP, 0xFF);
    }
}

/* handle data request on EP0 */
static void usb_handle_ep0buf_request(usb_t *usb)
{
    usb_set_ep0buf_ready(usb->per, false);
    if (USB_REQTYPE_GET_DIR(&usb->usb_setup) == USB_REQTYPE_DIR_TO_HOST)
    {
        /* check length of ep0 buffer/setup length */
        if (USB_SETUP_GET_LENGTH(&usb->usb_setup) < usb->ep0_length)
        {
            usb->ep0_length = USB_SETUP_GET_LENGTH(&usb->usb_setup);
        }
        usb_write_endpoint(usb, 0, usb->ep0_buffer, usb->ep0_length);
        usb->ep0_length = 0;
    }
    else
    {
        usb->ep0_length = usb_read_endpoint(usb, 0, usb->ep0_buffer, USB_EP0_BUFFER_SIZE);
    }
}

/**
 * @brief	Handle a USB request
 *
 * This function handles USB requests and must be called frequently
 *
 * @param	usb		usb driver pointer
 *
 * @return	none
 */
void usb_handle_request(usb_t *usb)
{
    if (usb_get_got_setup(usb->per))
    {
        /* handle a USB setup request */
        usb_handle_setup_request(usb);
    }
    else if (usb_get_ep0buf_ready(usb->per))
    {
        /* handle data on EP0 */
        usb_handle_ep0buf_request(usb);
    }
    else if (usb_get_got_out_data(usb->per))
    {
        /* skip it here? */
        usb_set_got_out_data(usb->per, false);
    }
}

/**
 * @brief	Read data from usb endpoint
 *
 * @param	usb			usb driver pointer
 * @param	endpoint	endpoint to read data from
 * @param	buffer		buffer to store read data
 * @param	max_length	maximum number of bytes to read
 *
 * @return	number of bytes read
 */
int usb_read_endpoint(usb_t *usb, uint8_t endpoint, uint8_t* buffer, int max_length)
{
    int     i, length, max_ep_length;
    uint8_t ep = USB_ENDPOINT(endpoint);

    max_ep_length = usb_get_packet_size(usb, endpoint);
    if (ep == 0)
    {
        /* for EP0 the length is stored in register EP0BC */
        length = usb_read_register(usb->per, EP0BC);
    }
    else
    {
        length = max_length;
    }

    /* read data */
    for (i = 0; i < length && i < max_length && i < max_ep_length; i++, buffer++)
    {
        *buffer = usb_read_endpoint_byte(usb, endpoint);
    }

    /* return the number of bytes read */
    return i;
}

/**
 * @brief	Read a byte from usb endpoint
 *
 * @param	usb			usb driver pointer
 * @param	endpoint	endpoint to read data from
 *
 * @return	byte read
 */
uint8_t usb_read_endpoint_byte(usb_t *usb, uint8_t endpoint)
{
    unsigned short  data = 0;

    //while (!usb_endpoint_ready(endpoint));
    switch (USB_ENDPOINT(endpoint))
    {
        case 0:
            data = usb_read_register(usb->per, EP0BUF);
            break;
        case 2:
            data = usb_read_data(usb->per, ADDRESS_FIFO2);
            break;
        case 4:
            data = usb_read_data(usb->per, ADDRESS_FIFO4);
            break;
        default:
            /* not handled */
            break;
    }
    return data & 0xFF;
}

/**
 * @brief Read 16 bits value from usb endpoint
 *
 * @param	usb			usb driver pointer
 * @param	endpoint	endpoint to read data from
 *
 * @return	data read
 */
uint16_t usb_read_endpoint_word(usb_t *usb, uint8_t endpoint)
{
    uint16_t        data;

    data   = usb_read_endpoint_byte(usb, endpoint);
    data <<= 8;
    data  |= usb_read_endpoint_byte(usb, endpoint);

    return little16(data);
}

/**
 * @brief	Read 32 bits value from usb endpoint
 *
 * @param	usb			usb driver pointer
 * @param	endpoint	endpoint to read data from
 *
 * @return	data read
 */
uint32_t usb_read_endpoint_dword(usb_t *usb, uint8_t endpoint)
{
    uint32_t        data;

    data   = usb_read_endpoint_byte(usb, endpoint);
    data <<= 8;
    data  |= usb_read_endpoint_byte(usb, endpoint);
    data <<= 8;
    data  |= usb_read_endpoint_byte(usb, endpoint);
    data <<= 8;
    data  |= usb_read_endpoint_byte(usb, endpoint);

    return little32(data);
}

/**
 * @brief	Write data to usb endpoint
 *
 * @param	usb			usb driver pointer
 * @param	endpoint	endpoint to write data to
 * @param	buffer		data for endpoint
 * @param	length		number of bytes to write to endpoint
 *
 * @return	number of bytes written
 */
int usb_write_endpoint(usb_t *usb, uint8_t endpoint, uint8_t* buffer, int length)
{
    int     i, max_ep_length;
    uint8_t ep = USB_ENDPOINT(endpoint);

    max_ep_length = usb_get_packet_size(usb, endpoint);
    if (length > max_ep_length)
    {
        length = max_ep_length;
    }
    for (i = 0; i < length; i++, buffer++)
    {
        usb_write_endpoint_byte(usb, endpoint, *buffer);
    }
    if (ep == 0)
    {
        /* for EP0 the length is stored in register EP0BC */
        usb_write_register(usb->per, EP0BC, (unsigned short) length);
    }
    if (length)
    {
        usb_endpoint_pktend(usb, endpoint);
    }
    return length;
}

/**
 * @brief	Write byte to usb endpoint
 *
 * @param	usb			usb driver pointer
 * @param	endpoint	endpoint to write data to
 * @param	data		byte to write to endpoint
 *
 * @return	none
 */
void usb_write_endpoint_byte(usb_t *usb, uint8_t endpoint, uint8_t data)
{
    //while (!usb_endpoint_ready(endpoint));
    switch (USB_ENDPOINT(endpoint))
    {
        case 0:
            usb_write_register(usb->per, EP0BUF, data);
            break;
        case 6:
            usb_write_data(usb->per, ADDRESS_FIFO6, data);
            break;
        case 8:
            usb_write_data(usb->per, ADDRESS_FIFO8, data);
            break;
        default:
            /* not handled */
            break;
    }
}

/**
 * @brief	Write 16 bits value to usb endpoint
 *
 * @param	usb			usb driver pointer
 * @param	endpoint	endpoint to write data to
 * @param	data		16 bits value to write to endpoint
 *
 * @return	none
 */
void usb_write_endpoint_word(usb_t *usb, uint8_t endpoint, uint16_t data)
{
    uint16_t    word = little16(data);

    usb_write_endpoint_byte(usb, endpoint, (uint8_t)((word >> 8) & 0xFF));
    usb_write_endpoint_byte(usb, endpoint, (uint8_t)(word & 0xFF));
}

/**
 * @brief	Write 32 bits value to usb endpoint
 *
 * @param	usb			usb driver pointer
 * @param	endpoint	endpoint to write data to
 * @param	data		value to write to usb endpoint
 *
 * @return	none
 */
void usb_write_endpoint_dword(usb_t *usb, uint8_t endpoint, uint32_t data)
{
    uint32_t    dword = little32(data);

    usb_write_endpoint_byte(usb, endpoint, (uint8_t)((dword >> 24) & 0xFF));
    usb_write_endpoint_byte(usb, endpoint, (uint8_t)((dword >> 16) & 0xFF));
    usb_write_endpoint_byte(usb, endpoint, (uint8_t)((dword >> 8) & 0xFF));
    usb_write_endpoint_byte(usb, endpoint, (uint8_t)(dword & 0xFF));
}

/**
 * @brief	Check it endpoint a a valid end point
 *
 * @param	usb			usb driver pointer
 * @param	endpoint	endpoint number
 *
 * @return	true valid endpoint false invalid endpoint
 */
bool usb_endpoint_is_valid(usb_t *usb, uint8_t endpoint)
{
    bool    valid = false;

    switch (USB_ENDPOINT(endpoint))
    {
        case 0:
        case 2:
        case 4:
        case 6:
        case 8:
            valid = true;
            break;
        default:
            /* not handled */
            break;
    }
    return valid;
}

/**
 * @brief	Check for endpoint ready status
 *
 * @param	usb			usb driver pointer
 * @param	endpoint	endpoint to check for ready status
 *
 * @return	true, ready false, otherwise
 */
bool usb_endpoint_ready(usb_t *usb, uint8_t endpoint)
{
    bool    ready = false;

    switch (USB_ENDPOINT(endpoint))
    {
        case 0:
            ready = true;
            break;
        case 2:
            ready = (usb_read_low_level(usb->per, ADDRESS_STATUS|ADDRESS_FIFO2) & STATUS_MASK_FLAGC) != 0;
            break;
        case 4:
            ready = (usb_read_low_level(usb->per, ADDRESS_STATUS|ADDRESS_FIFO4) & STATUS_MASK_FLAGC) != 0;
            break;
        case 6:
            ready = (usb_read_low_level(usb->per, ADDRESS_STATUS|ADDRESS_FIFO6) & STATUS_MASK_FLAGB) != 0;
            break;
        case 8:
            ready = (usb_read_low_level(usb->per, ADDRESS_STATUS|ADDRESS_FIFO8) & STATUS_MASK_FLAGB) != 0;
            break;
        default:
            /* not handled */
            break;
    }
    return ready;
}

/**
 * @brief	enable endpoint
 *
 * @param	usb			usb driver pointer
 * @param	endpoint	endpoint to enable
 *
 * @return	none
 */
void usb_enable_endpoint(usb_t *usb, uint8_t endpoint)
{
    switch (USB_ENDPOINT(endpoint))
    {
        case 2:
            usb_set_register_bit(usb->per, EP2CFG, 7);
            break;
        case 4:
            usb_set_register_bit(usb->per, EP4CFG, 7);
            break;
        case 6:
            usb_set_register_bit(usb->per, EP6CFG, 7);
            break;
        case 8:
            usb_set_register_bit(usb->per, EP8CFG, 7);
            break;
        default:
            /* not handled */
            break;
    }
}

/**
 * @brief	disable an endpoint
 *
 * @param	usb			usb driver pointer
 * @param	endpoint	endpoint to disable
 *
 * @return	none
 */
void usb_disable_endpoint(usb_t *usb, uint8_t endpoint)
{
    switch (USB_ENDPOINT(endpoint))
    {
        case 2:
            usb_clear_register_bit(usb->per, EP2CFG, 7);
            break;
        case 4:
            usb_clear_register_bit(usb->per, EP4CFG, 7);
            break;
        case 6:
            usb_clear_register_bit(usb->per, EP6CFG, 7);
            break;
        case 8:
            usb_clear_register_bit(usb->per, EP8CFG, 7);
            break;
        default:
            /* not handled */
            break;
    }
}

/**
 * @brief	check if the specified endpoint is enabled
 *
 * @param	usb			usb driver pointer
 * @param	endpoint	endpoint to check
 *
 * @return	true, endpoint is enabled false, otherwise
 */
bool usb_endpoint_is_enabled(usb_t *usb, uint8_t endpoint)
{
    bool            enabled = false;
    unsigned short  curval = 0;

    switch (USB_ENDPOINT(endpoint))
    {
        case 2:
            curval = usb_read_register(usb->per, EP2CFG);
            break;
        case 4:
            curval = usb_read_register(usb->per, EP4CFG);
            break;
        case 6:
            curval = usb_read_register(usb->per, EP6CFG);
            break;
        case 8:
            curval = usb_read_register(usb->per, EP8CFG);
            break;
        default:
            /* not handled */
            break;
    }
    enabled = (curval & 0x80) == 0x80;
    return enabled;
}

/**
 * @brief	stall an endpoint
 *
 * @param	usb			usb driver pointer
 * @param	endpoint	endpoint to stall
 *
 * @return	none
 */
void usb_stall_endpoint(usb_t *usb, uint8_t endpoint)
{
    switch (USB_ENDPOINT(endpoint))
    {
        case 2:
            usb_set_register_bit(usb->per, EP2CFG, 2);
            usb_write_register(usb->per, EP0BC, 0);
            break;
        case 4:
            usb_set_register_bit(usb->per, EP4CFG, 2);
            usb_write_register(usb->per, EP0BC, 0);
            break;
        case 6:
            usb_set_register_bit(usb->per, EP6CFG, 2);
            usb_write_register(usb->per, EP0BC, 0);
            break;
        case 8:
            usb_set_register_bit(usb->per, EP8CFG, 2);
            usb_write_register(usb->per, EP0BC, 0);
            break;
        default:
            /* not handled */
            break;
    }
}

/**
 * @brief	unstall an endpoint
 *
 * @param	usb			usb driver pointer
 * @param	endpoint	endpoint to unstall
 *
 * @return	none
 */
void usb_unstall_endpoint(usb_t *usb, uint8_t endpoint)
{
    switch (USB_ENDPOINT(endpoint))
    {
        case 2:
            usb_clear_register_bit(usb->per, EP2CFG, 2);
            usb_write_register(usb->per, EP0BC, 0);
            break;
        case 4:
            usb_clear_register_bit(usb->per, EP4CFG, 2);
            usb_write_register(usb->per, EP0BC, 0);
            break;
        case 6:
            usb_clear_register_bit(usb->per, EP6CFG, 2);
            usb_write_register(usb->per, EP0BC, 0);
            break;
        case 8:
            usb_clear_register_bit(usb->per, EP8CFG, 2);
            usb_write_register(usb->per, EP0BC, 0);
            break;
        default:
            /* not handled */
            break;
    }
}

/**
 * @brief	send a PKTEND to an endpoint
 *
 * @param	usb			usb driver pointer
 * @param	endpoint	endpoint to PTKEND
 *
 * @return	none
 */
void usb_endpoint_pktend(usb_t *usb, uint8_t endpoint)
{
    switch (USB_ENDPOINT(endpoint))
    {
        case 6:
            usb_flush(usb->per, ADDRESS_FIFO6);
            break;
        case 8:
            usb_flush(usb->per, ADDRESS_FIFO8);
            break;
        default:
            /* not handled */
            break;
    }
}

