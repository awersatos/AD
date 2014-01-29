#define LCD_DATA   P1
#define LCD_BF     P1_7

#define LCD_RW     P0_1
#define LCD_RS     P0_0
#define LCD_E      P0_2
#define LCD_LIGHT  P0_3

#ifdef LCD_DISABLE
#define LCD_BUSY   0
#else
#define LCD_BUSY   (LCD_IR_Read() & 0x80)
#endif

#define LCD_Set_CGRAM_Address(Address) while(LCD_BUSY); LCD_IR_Write((Address & 0x3F) | 0x40)
#define LCD_Set_DDRAM_Address(Address) while(LCD_BUSY); LCD_IR_Write(Address | 0x80)
#define LCD_Putch(ch) LCD_DR_Write(ch)

#define ROW0       0x00
#define ROW1       0x40

void inline   Write_LCD(unsigned char Data);
void          LCD_IR_Write(unsigned char Data);
void          LCD_DR_Write(unsigned char Data);
unsigned char LCD_IR_Read(void);
unsigned char LCD_DR_Read(void);
void          InitLCD(void);
void          LCD_WriteString(const char *str);
void          LCD_WriteChar(unsigned char c);

void          LCD_ClearDisplay(void);
void          LCD_WriteNibble (unsigned char X);
void          LCD_Write8bit (unsigned char X);
void          LCD_Write16bit (unsigned int X);
void          LCD_Write32bit (unsigned long int X);

void          LCD_WriteByteAsSignedDec(signed char Val);

void          LCD_GotoXY(unsigned char X, unsigned char Y);


