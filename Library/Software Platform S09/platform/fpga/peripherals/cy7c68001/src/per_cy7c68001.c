
#include <per_cy7c68001_cfg_instance.h>
#include <per_cy7c68001_cfg.h>
#include <per_cy7c68001.h>
#include <stdint.h>
#include <time.h>
#include <timing.h>
#include <interrupts.h>
#include <assert.h>


struct cy7c68001_s {
    volatile unsigned short     *base_address;
    uint32_t                    data_intr;
    uint32_t                    control_intr;
    bool                        word_mode; //set to true if using chip in 16 bit mode
    // status fields
    volatile bool               ready;
    volatile bool               no_activity;
    volatile bool               enum_ok;
    // data available flags: user to clear after  handled
    volatile bool               got_out_data;
    volatile bool               ep0buf_ready;
    volatile bool               got_setup;
    // internal fields
    volatile unsigned short     data_buffer;
    volatile bool               waiting_for_data;
    volatile bool               data_ready;
};

static cy7c68001_t per_table[PER_CY7C68001_INSTANCE_COUNT];


unsigned short usb_read_low_level(cy7c68001_t *context, unsigned int address)
{
    return *(context->base_address + address);
}

inline void usb_write_low_level(cy7c68001_t *context, unsigned int address, unsigned short value)
{
    // wait USB_READY signal is high.
    // USB_READY will go low for a while when writing a command.
    if (address == ADDRESS_COMMAND)
    {
        while(!(usb_read_low_level(context, ADDRESS_STATUS) & STATUS_MASK_READY))
        {
        }
    }
    *(context->base_address + address) = value;
}

inline void usb_write_low_level_non_command(cy7c68001_t *context, unsigned int address, unsigned short value)
{
    *(context->base_address + address) = value;
}

void usb_write_register(cy7c68001_t* context, unsigned int register_num, unsigned short value)
{
    usb_write_low_level(context, ADDRESS_COMMAND, COMMAND_WRITE_ADDRESS_BYTE(register_num));
    usb_write_low_level(context, ADDRESS_COMMAND, COMMAND_WRITE_DATA_BYTE1(value));
    usb_write_low_level(context, ADDRESS_COMMAND, COMMAND_WRITE_DATA_BYTE2(value));
}

void usb_write_data(cy7c68001_t* context, unsigned int address, unsigned short value)
{
    usb_write_low_level(context, address, value);
}

inline void usb_write_data_ep6(cy7c68001_t* context, unsigned short value)
{
    usb_write_data(context, ADDRESS_FIFO6, value);
}

inline void usb_write_data_ep8(cy7c68001_t *context, unsigned short value)
{
    usb_write_data(context, ADDRESS_FIFO8, value);
}

unsigned short usb_read_register(cy7c68001_t *context, unsigned int register_num)
{
    context->data_ready = false;
    context->waiting_for_data = true;

    usb_write_low_level(context, ADDRESS_COMMAND, COMMAND_READ_ADDRESS_BYTE(register_num));
    while (!context->data_ready)
    {
        // wait for data read back from interrupt handler
    }

    return context->data_buffer;
}

inline bool usb_data_is_available(cy7c68001_t *context, unsigned int address)
{
    return (usb_read_low_level(context, ADDRESS_STATUS | address) & STATUS_MASK_FLAGC) != 0;
}

inline bool usb_data_is_available_ep2(cy7c68001_t *context)
{
    return usb_data_is_available(context, ADDRESS_FIFO2);
}

inline bool usb_data_is_available_ep4(cy7c68001_t *context)
{
    return usb_data_is_available(context, ADDRESS_FIFO4);
}

unsigned short usb_read_data(cy7c68001_t *context, unsigned int address)
{
    return usb_read_low_level(context, address);
}

inline unsigned short usb_read_data_ep2(cy7c68001_t *context)
{
    return usb_read_data(context, ADDRESS_FIFO2);
}

inline unsigned short usb_read_data_ep4(cy7c68001_t *context)
{
    return usb_read_data(context, ADDRESS_FIFO4);
}

void usb_flush(cy7c68001_t *context, unsigned int address)
{
    usb_write_low_level(context, ADDRESS_FLUSH | address, 0);
}

inline void usb_flush_ep6(cy7c68001_t *context)
{
    usb_flush(context, ADDRESS_FIFO6);
}

inline void usb_flush_ep8(cy7c68001_t *context)
{
    usb_flush(context, ADDRESS_FIFO8);
}

//........ Local Functions .....................................................
void usb_handle_interrupt(cy7c68001_t* context);
//..............................................................................

//..............................................................................
uint8_t cycles_for_ns(uint32_t ns)
{
    uint32_t ns_per_cycle;
    uint8_t  result;

    ns_per_cycle = 1000000000 / CLOCKS_PER_SEC;
    result       = ns / ns_per_cycle;
    if ((ns % ns_per_cycle) != 0)
        result++;
    return result;
}
//..............................................................................

//..............................................................................
void usb_set_all_to_8_bit(cy7c68001_t *context)
{
    unsigned short current_val;

    current_val = usb_read_register(context, EP2PKTLENH);
    usb_write_register(context, EP2PKTLENH, current_val & 0xEF);

    current_val = usb_read_register(context, EP4PKTLENH);
    usb_write_register(context, EP4PKTLENH, current_val & 0xEF);

    current_val = usb_read_register(context, EP6PKTLENH);
    usb_write_register(context, EP6PKTLENH, current_val & 0xEF);

    current_val = usb_read_register(context, EP8PKTLENH);
    usb_write_register(context, EP8PKTLENH, current_val & 0xEF);
}
//..............................................................................

//..............................................................................
void usb_set_all_to_16_bit(cy7c68001_t *context)
{
    unsigned short current_val;

    current_val = usb_read_register(context, EP2PKTLENH);
    usb_write_register(context, EP2PKTLENH, current_val | 0x10);

    current_val = usb_read_register(context, EP4PKTLENH);
    usb_write_register(context, EP4PKTLENH, current_val | 0x10);

    current_val = usb_read_register(context, EP6PKTLENH);
    usb_write_register(context, EP6PKTLENH, current_val | 0x10);

    current_val = usb_read_register(context, EP8PKTLENH);
    usb_write_register(context, EP8PKTLENH, current_val | 0x10);
}
//..............................................................................

//..............................................................................
void usb_init(cy7c68001_t *context, int length, unsigned char* descriptor)
{
    usb_write_low_level(context, ADDRESS_CYCLES_RESET        , cycles_for_ns(1000));
    usb_write_low_level(context, ADDRESS_CYCLES_STROBELOW    , cycles_for_ns(  50)-1);
    usb_write_low_level(context, ADDRESS_CYCLES_STROBEHIGH   , cycles_for_ns(  50)-1);
    usb_write_low_level(context, ADDRESS_CYCLES_WRHIGH       , cycles_for_ns(  70)-1);
    usb_write_low_level(context, ADDRESS_CYCLES_ADDRESSSETUP , cycles_for_ns(  50)-1);
    usb_write_low_level(context, ADDRESS_CYCLES_READSTATUS   , cycles_for_ns(  50)-1);
    usb_reset(context);
    while (!context->ready)
    {
        /* wait for USB to become ready */
    }
    if (!context->word_mode)
    {
        /* set to 8-bit mode */
        usb_set_all_to_8_bit(context);
    }
    usb_write_descriptor(context, length, descriptor);
}

//..............................................................................

//..............................................................................
void usb_handle_interrupt(cy7c68001_t *context)
{
    unsigned short  interrupt_status;

    interrupt_status = usb_read_low_level(context, ADDRESS_COMMAND) & 0xFFFF;
    switch (interrupt_status)
    {
        case 0x01: //Ready
            context->ready = true;
            break;
        case 0x02: //Bus Activity
            context->no_activity = !context->no_activity;
            break;
        case 0x04: //Enumeration complete
            context->enum_ok = true;
            break;
        case 0x20: //Flags
            context->got_out_data = true;
            context->no_activity = false;
            break;
        case 0x40: //EP0Buf
            context->ep0buf_ready = true;
            break;
        case 0x80: //Setup
            context->got_setup = true;
            break;
        default:
            break;
    }
}
//..............................................................................

//..............................................................................
void usb_data_ready_interrupt(cy7c68001_t* context)
{
    // data is ready before trying to read it means, so must be a control interrupt
    if (context->waiting_for_data)
    {
        context->data_buffer      = usb_read_low_level(context, ADDRESS_COMMAND);
        context->data_ready       = true;
        context->waiting_for_data = false;
    }
    else
    {
        usb_handle_interrupt(context);
    }
}
//..............................................................................

//..............................................................................
void usb_control_interrupt(cy7c68001_t *context)
{
    usb_handle_interrupt(context);
}
//..............................................................................

//..............................................................................
void usb_write_descriptor(cy7c68001_t *context, int length, unsigned char *data)
{
    int i;

    usb_write_low_level(context, ADDRESS_COMMAND, COMMAND_WRITE_ADDRESS_BYTE(DESC));
    usb_write_low_level(context, ADDRESS_COMMAND, COMMAND_WRITE_DATA_BYTE1(length & 0xFF));
    usb_write_low_level(context, ADDRESS_COMMAND, COMMAND_WRITE_DATA_BYTE2(length & 0xFF));
    usb_write_low_level(context, ADDRESS_COMMAND, COMMAND_WRITE_DATA_BYTE1((length >> 8) & 0xFF));
    usb_write_low_level(context, ADDRESS_COMMAND, COMMAND_WRITE_DATA_BYTE2((length >> 8) & 0xFF));

    for (i = 0; i < length; i++)
    {
        usb_write_low_level(context, ADDRESS_COMMAND, COMMAND_WRITE_DATA_BYTE1(data[i]));
        usb_write_low_level(context, ADDRESS_COMMAND, COMMAND_WRITE_DATA_BYTE2(data[i]));
    }
}
//..............................................................................

//..............................................................................
void usb_reset(cy7c68001_t *context)
{
    *(context->base_address + ADDRESS_RESET) = 1;
    delay_ms(100);
}
//..............................................................................


/* USB data interrupt handler */
static uint32_t usb_data_isr(uint32_t interrupt_num, void *context)
{
    interrupt_acknowledge(interrupt_num);
    usb_data_ready_interrupt(context);
    return INTERRUPT_HANDLED;
}

/* USB control interrupt handler */
static uint32_t usb_control_isr(uint32_t interrupt_num, void *context)
{
    interrupt_acknowledge(interrupt_num);
    usb_control_interrupt(context);
    return INTERRUPT_HANDLED;
}

/* initialize USB interrupts */
void initialize_usb_interrupts(cy7c68001_t *per)
{
    /* register interrupt handlers */
    if (interrupt_register(per->data_intr, per, usb_data_isr) != true)
    {
        __nop();
    }
    if (interrupt_configure(per->data_intr, EDGE_RISING) != true)
    {
        __nop();
    }
    interrupt_enable(per->data_intr);

    if (interrupt_register(per->control_intr, per, usb_control_isr) != true)
    {
        __nop();
    }
    if (interrupt_configure(per->control_intr, EDGE_RISING) != true)
    {
        __nop();
    }
    interrupt_enable(per->control_intr);
}

cy7c68001_t *cy7c68001_open(int id)
{
    assert((id >= 0) && (id < PER_CY7C68001_INSTANCE_COUNT));

    cy7c68001_t *per = &per_table[id];
    per_cy7c68001_cfg_instance_t *per_cfg = &per_cy7c68001_instance_table[id];

    per->base_address = per_cfg->baseaddress;
    per->data_intr = per_cfg->data_intr;
    per->control_intr = per_cfg->control_intr;
    initialize_usb_interrupts(per);

    return per;
}

bool usb_set_got_setup(cy7c68001_t *context, bool val)
{
    bool ret = context->got_setup;
    context->got_setup = val;
    return ret;
}

bool usb_get_got_setup(cy7c68001_t *context)
{
    return context->got_setup;
}

bool usb_set_ep0buf_ready(cy7c68001_t *per, bool val)
{
    bool ret = per->ep0buf_ready;
    per->ep0buf_ready = val;
    return ret;
}

bool usb_get_ep0buf_ready(cy7c68001_t *per)
{
    return per->ep0buf_ready;
}

bool usb_set_got_out_data(cy7c68001_t *per, bool val)
{
    bool ret = per->got_out_data;
    per->got_out_data = val;
    return ret;
}

bool usb_get_got_out_data(cy7c68001_t *per)
{
    return per->got_out_data;
}

/* set specific bit(s) in a USB register */
void usb_set_register_bit(cy7c68001_t *per, int register_num, unsigned short bitnum)
{
    unsigned short  value = (1 << bitnum);
    usb_set_register_bitmask(per, register_num, value, value);
}

void usb_set_register_bitmask(cy7c68001_t *per, int register_num, unsigned short mask, unsigned short bits)
{
    unsigned short  value;

    value  = usb_read_register(per, register_num);
    value &= ~mask;
    value |= bits;
    usb_write_register(per, register_num, value);
}

/* clear specific bit(s) in a USB register */
void usb_clear_register_bit(cy7c68001_t *per, int register_num, unsigned short bitnum)
{
    unsigned short  value = (1 << bitnum);
    usb_clear_register_bitmask(per, register_num, value, value);
}

void usb_clear_register_bitmask(cy7c68001_t *per, int register_num, unsigned short mask, unsigned short bits)
{
    unsigned short  value;

    value  = usb_read_register(per, register_num);
    value &= ~mask;
    value &= ~bits;
    usb_write_register(per, register_num, value);
}

