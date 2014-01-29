#include "LCD_Control.h"
#include "TimeTSK51.h"

void inline Write_LCD(unsigned char Data)
{
#ifndef LCD_DISABLE
    LCD_DATA = Data;
    LCD_E = 1;
    LCD_E = 0;
#endif
}

void LCD_IR_Write(unsigned char Data)
{
#ifndef LCD_DISABLE
    LCD_RS = 0;
    LCD_RW = 0;
    Write_LCD(Data);
#endif
}

void LCD_DR_Write(unsigned char Data)
{
#ifndef LCD_DISABLE
    while (LCD_BUSY)
        ;
    LCD_RS = 1;
    LCD_RW = 0;
    Write_LCD(Data);
#endif
}

unsigned char LCD_IR_Read(void)
{
#ifndef LCD_DISABLE
    unsigned char ch;
    LCD_RS = 0;
    LCD_RW = 1;
    LCD_E = 1;
    ch = LCD_DATA;
    LCD_E = 0;
    return(ch);
#else
    return(0);
#endif
}

unsigned char LCD_DR_Read(void)
{
#ifndef LCD_DISABLE
    unsigned char ch;
    LCD_RS = 1;
    LCD_RW = 1;
    LCD_E = 1;
    ch = LCD_DATA;
    LCD_E = 0;
    return(ch);
#else
    return(0);
#endif
}

void InitLCD(void)
{
#ifndef LCD_DISABLE
    LCD_RS = 0;
    LCD_RW = 0;
    LCD_E = 0;
    LCD_DATA = 0x00;

    Wait_1ms(40);                                      //Wait more than 40ms;
    LCD_IR_Write(0x38);
    Wait_1ms(5);                                       //Wait more than 4.1ms
    LCD_IR_Write(0x38);
    Wait_10us(10);                                     //Wait more than 100us
    LCD_IR_Write(0x38);                                //Function Set, 8-bit, 2 line
    Wait_1ms(1);

    LCD_IR_Write(0x01);                                //Clear Display;
    while (LCD_BUSY)
        ;

    LCD_IR_Write(0x0E);                                //Turn Display and cursor ON
    while (LCD_BUSY)
        ;

    LCD_IR_Write(0x06);                                //Increment address counter and move cursor by 1
    while (LCD_BUSY)
        ;
#endif
}

void LCD_WriteString(const char * str)
{
#ifndef LCD_DISABLE
    while (* str)
    {
        LCD_Putch(* str++);
    }
#endif
}

void LCD_WriteChar(unsigned char c)
{
#ifndef LCD_DISABLE
    while (LCD_BUSY);
    LCD_Putch(c);
#endif
}

void LCD_GotoXY(unsigned char X, unsigned char Y)
{
#ifndef LCD_DISABLE
    while (LCD_BUSY)
        ;
    LCD_IR_Write(0x02);
    while (LCD_BUSY)
        ;
    LCD_IR_Write(0x80 | (X + (0x40* Y) ));
#endif
}

void LCD_ClearDisplay(void)
{
#ifndef LCD_DISABLE
    while (LCD_BUSY)
        ;
    LCD_IR_Write(0x01);
#endif
}

void LCD_WriteNibble(unsigned char X)
{
#ifndef LCD_DISABLE
    if (X > 0x0F)
        return;

    if (X >= 10)
        LCD_Putch('A' - 10 + X);
    else
        LCD_Putch('0' + X);
#endif
}

void LCD_Write8bit(unsigned char X)
{
#ifndef LCD_DISABLE
    LCD_WriteNibble(X >> 4);
    LCD_WriteNibble(X & 0x0F);
#endif
}

void LCD_Write16bit(unsigned int X)
{
#ifndef LCD_DISABLE
    LCD_Write8bit(X >> 8);
    LCD_Write8bit(X & 0x00FF);
#endif
}

void LCD_Write32bit(unsigned long int X)
{
#ifndef LCD_DISABLE
    LCD_Write16bit(X >> 16);
    LCD_Write16bit(X & 0x0000FFFF);
#endif
}

void LCD_WriteByteAsSignedDec(signed char Val)
{
#ifndef LCD_DISABLE
    signed char t1, t2;
    char HaveWritten = 0;

    if (Val < 0)
       {
        LCD_Putch('-');
        Val *= -1;
       }

    t1 = Val / 100;
    if (t1 != 0)
    {
        LCD_Putch(t1 + '0');
        HaveWritten = 1;
    }

    t1 = Val % 100;
    t2 = t1/10;
    if (t2 != 0 || HaveWritten == 1)
    {
       LCD_Putch(t2 + '0');
       HaveWritten = 1;
    }

    t1 = Val % 10;
    LCD_Putch(t1 + '0');
#endif
}
   
