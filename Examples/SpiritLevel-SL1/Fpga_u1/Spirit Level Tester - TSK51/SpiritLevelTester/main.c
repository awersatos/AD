#include "hware.h"
#include "LCD_Control.h"
#include "TimeTSK51.h"

#define SELECT_X_AXIS_ALT AXIS_PORT=0
#define SELECT_Y_AXIS_ALT AXIS_PORT=1
#define SELECT_X_AXIS_JPR AXIS_PORT=3
#define SELECT_Y_AXIS_JPR AXIS_PORT=2
#define X_AXIS            AXIS_PORT == 0 || AXIS_PORT == 3

unsigned char __xdata ErrorCount;                      // tallies the number of errors 
signed   long __xdata DelXAg;
signed   long __xdata DelYAg;
signed   long __xdata Ag;
signed   char __xdata AgDash;
signed   char __xdata sign;
signed   char __xdata Angle;

signed   char __rom LookupAngle[] = {
        0,  //0
        0,  //1
        1,  //2
        1,  //3
        2,  //4
        2,  //5
        3,  //6
        3,  //7
        4,  //8
        4,  //9
        4,  //10
        5,  //11
        5,  //12
        6,  //13
        6,  //14
        7,  //15
        7,  //16
        8,  //17
        8,  //18
        8,  //19
        9,  //20
        9,  //21
        10,  //22
        10,  //23
        11,  //24
        11,  //25
        12,  //26
        12,  //27
        13,  //28
        13,  //29
        13,  //30
        14,  //31
        14,  //32
        15,  //33
        15,  //34
        16,  //35
        16,  //36
        17,  //37
        17,  //38
        18,  //39
        18,  //40
        19,  //41
        19,  //42
        20,  //43
        20,  //44
        21,  //45
        21,  //46
        22,  //47
        22,  //48
        22,  //49
        23,  //50
        23,  //51
        24,  //52
        24,  //53
        25,  //54
        25,  //55
        26,  //56
        26,  //57
        27,  //58
        27,  //59
        28,  //60
        28,  //61
        29,  //62
        29,  //63
        30,  //64
        31,  //65
        31,  //66
        32,  //67
        32,  //68
        33,  //69
        33,  //70
        34,  //71
        34,  //72
        35,  //73
        35,  //74
        36,  //75
        36,  //76
        37,  //77
        38,  //78
        38,  //79
        39,  //80
        39,  //81
        40,  //82
        40,  //83
        41,  //84
        42,  //85
        42,  //86
        43,  //87
        44,  //88
        44,  //89
        45,  //90
        45,  //91
        46,  //92
        47,  //93
        47,  //94
        48,  //95
        49,  //96
        49,  //97
        50,  //98
        51,  //99
        52,  //100
        52,  //101
        53,  //102
        54,  //103
        55,  //104
        55,  //105
        56,  //106
        57,  //107
        58,  //108
        59,  //109
        60,  //110
        61  //111
};

signed long CalcAngleRef(unsigned int T1, unsigned int T2)
{
    signed long Ag;

    Ag = (long) T1 << 16;
    Ag = Ag / (long) T2;
    Ag = Ag - (1L << 15);

    Ag = ((1L << 16) * T1) / T2 - (1L << 15);

    return(Ag);
}

//----------------------------------------------------------
// Makes sure every dip switch is activated individually
// Test/Reset key aborts test
// returns 0: success 1: aborted
//----------------------------------------------------------
unsigned char TestDipSwitches(void)
{
    unsigned char finished;
    unsigned char c,i, jumpers = 0;
    unsigned char patterns[]={0x01,0x02,0x04,0x08,0x10,0x20,0x40,0x80};

    LCD_WriteString("  DIP-Switches  ");

    do
    {
        if (KEY_PORT == 1)
        {
            return 1;
        }

        LCD_GotoXY(0,1);
        LCD_WriteString("                ");
        finished = 1;

        LCD_GotoXY(4,1);
        for(i=0; i<8; i++)
        {
            if(0 == patterns[i])
            {
                LCD_WriteChar(0xFF);
            }
            else
            {
                LCD_WriteChar(0x30+i+1);
                finished = 0;
            }
        }
        c = ~DIP_PORT;
        LED_PORT = c;                                  // mirror DIP-switches on LEDs
        for(i=0; i<8; i++)
        {
            if (c == patterns[i])
            {
                if(patterns[i] != 0)                   // new valid pattern?
                {
                    patterns[i] = 0;                   // mark in pattern array as done
                }
            }
        }
        Wait_1ms(10);
    }
    while (finished == 0);

    LED_PORT = 0;

    return 0;
}

// ----------------------------------------------------------
// Does the 'Knightrider Thing' with the LEDs on the SLBoard
// ----------------------------------------------------------
void KnightRider(unsigned int OnTimeMs, unsigned char count)
{
    unsigned int direction = 0;
    register unsigned char pattern = 1;

    while(count--)
    {
        LED_PORT = pattern;                            // set LED[0..7] to pattern
        Wait_1ms(OnTimeMs);
        if(0 == direction)                             // move right
        {
            pattern <<= 1;
            if(0==pattern)
            {
                direction = 1;
                pattern = 0x40;
            }
        }
        else                                           // move left
        {
            pattern >>= 1;
            if(0==pattern)
            {
                direction = 0;
                pattern = 0x02;
            }
        }
    }
    LED_PORT = 0;                                      // turn all LEDs off when exiting
}

void Standard_Character_Pattern_Test(void)
{
    unsigned char line = 0;

    for(unsigned char i=0; i<255; i++)
    {
        if(0==(i & 0x0F))
        {
            LCD_GotoXY(0,line);
            line ^=1;
            if(line)
            {
                KnightRider(30,15);
            }
        }
        LCD_WriteChar(i);
    }
    LCD_ClearDisplay();
}

//------------------------------------------------------------------------------------
// Outputs walking pattern of ones on user Header A and reads it back on user Header B
// returns     0 : OK
//         non-0 : bit at which error occurred
//------------------------------------------------------------------------------------
unsigned char TestUserIO(void)
{
    unsigned long OutValue = 0x01L;
    unsigned long InValue  = 0;
    unsigned char bit = 1;

    AXIS_PORT = 0;
    LCD_WriteString("    USER IOs    ");
    do
    {
        OutValue &= 0x0003FFFFL;                       // only 18 significant bits
        U1H0_PORT = OutValue  & 0xFF;
        U1H1_PORT = (OutValue >> 8 ) & 0xFF;
        U1H2_PORT = (OutValue >> 16) & 0xFF;
        Wait_1ms(1);
        InValue   = U1H2_PORT & 0x03;
        InValue <<= 8;
        InValue  |= U1H1_PORT;
        InValue <<= 8;
        InValue  |= U1H0_PORT;
        if(InValue != OutValue)
            goto FoundError;
        OutValue <<= 1;
        bit++;
        Wait_1ms(1);
    }
    while (0 != OutValue);

    return (0);

    FoundError:

    return (bit);
}

signed long GetDeltaAngle(void)
{
    signed long DelAg = 0;

    Time0_updated = 0;
    do
    {
        DelAg = ((1L << 16) * X_T1) / X_T2 - (1L << 15);
        __asm("nop");
    }
    while (Time0_updated < 11);

    return (DelAg);
}

void CalibrateSpiritLevel(void)
{
    LCD_GotoXY(0,0);
    LCD_WriteString("Remove Jumpers  ");
    LCD_GotoXY(0,1);
    LCD_WriteString("Press TEST/RESET");

    while (KEY_PORT == 0);

    LCD_GotoXY(0,0);
    LCD_WriteString("  Calibrating   ");
    LCD_GotoXY(0,1);
    LCD_WriteString("  X/Y AXIS...   ");

    SELECT_X_AXIS_ALT;
    DelXAg = GetDeltaAngle();

    Wait_1s(1);
    SELECT_Y_AXIS_ALT;
    DelYAg = GetDeltaAngle();

    LCD_GotoXY(0,0);
    LCD_WriteString("Calib. Completed");
    LCD_GotoXY(0,1);
    LCD_WriteString("Press TEST/RESET");

    while (KEY_PORT == 0);
    LCD_ClearDisplay();
    Wait_1ms(500);
}

//-------------------------------------------------------------------------
// Flash LEDs and asks for keypress if 'code' is non-0
// prints OK for for a short time and exits if 'code is 0
// increases global variable 'ErrorCount' if 'code' is non-0
//-------------------------------------------------------------------------
void ErrorLEDs(unsigned char code)
{
    unsigned char Test_Button = 0;

    LCD_GotoXY(0,1);
    if(0 == code)
    {
        LCD_WriteString(" PASSED - RESET ");
        while (KEY_PORT == 0);
    }
    else
    {
        ErrorCount++;
        LCD_WriteString(" FAILED - RESET ");
        do
        {
            LED_PORT = 0xFF;
            Wait_1ms(50);
            if (KEY_PORT) Test_Button = 1;
            LED_PORT = 0x00;
            Wait_1ms(50);
            if (KEY_PORT) Test_Button = 1;
        } while (Test_Button == 0);
    }
    LCD_ClearDisplay();
    LED_PORT = 0x00;
    Wait_1ms(100);
}

void Hello(void)
{
    LCD_LIGHT = 0;
    InitLCD();
    LCD_LIGHT = 1;
    LCD_ClearDisplay();
    LCD_GotoXY(0, 0);
    LCD_WriteString("LCD Spirit Level");
    LCD_GotoXY(0, 1);
    LCD_WriteString("Board Tester 1.0");
    Wait_1ms(500);

    LCD_GotoXY(0, 0);
    LCD_WriteString("Adjust Contrast ");
    LCD_GotoXY(0, 1);
    LCD_WriteString("Press TEST/RESET");
    while (KEY_PORT == 0);
}

void SpiritLevel(void)
{
    signed long DelAg = 0;

    if (X_AXIS)
    {
        DelAg = DelXAg;
    }
    else
    {
        DelAg = DelYAg;
    }

    Wait_1ms(100);
    while (KEY_PORT == 0)
    {
        if (Time0_updated > 10)
        {
            Time0_updated = 0;
            LCD_Set_DDRAM_Address(0);
            LCD_Set_DDRAM_Address(40);

            Ag = ((1L << 16) * X_T1) / X_T2 - (1L << 15);
            Ag = Ag - DelAg;

            AgDash = (signed char)(Ag / 64);

            sign = AgDash < 0 ? - 1: 1;
            AgDash *= sign;
            if (AgDash > 110)
            {
                Angle = 61 * sign;
            }
            else
            {
                Angle = LookupAngle[AgDash] * sign;
            }

            LCD_Set_DDRAM_Address(ROW1 + 11);
            if (Angle < - 60)
                LCD_WriteString("<");
            else if (Angle <= 60)
                LCD_WriteString(" ");
            else
                LCD_WriteString(">");
            LCD_WriteByteAsSignedDec(Angle);
            LCD_DR_Write(0xDF);
            LCD_WriteString("     ");
        }
    }
    Wait_1ms(500);
    LCD_ClearDisplay();
}

void TestAccelerometerAxisXAlt(void)
{
    SELECT_X_AXIS_ALT;
    LCD_WriteString("Accelero. X Axis");
    SpiritLevel();
}

void TestAccelerometerAxisYAlt(void)
{
    SELECT_Y_AXIS_ALT;
    LCD_WriteString("Accelero. Y Axis");
    SpiritLevel();
}

void TestAccelerometerAxisXJpr(void)
{
    SELECT_X_AXIS_JPR;
    LCD_WriteString("Jumper on X Axis");
    LCD_GotoXY(0, 1);
    LCD_WriteString("Press TEST/RESET");
    while (KEY_PORT == 0);
    LCD_ClearDisplay();
    LCD_WriteString("X Axis From HA3 ");
    SpiritLevel();
}

void TestAccelerometerAxisYJpr(void)
{
    SELECT_Y_AXIS_JPR;
    LCD_WriteString("Jumper on Y Axis");
    LCD_GotoXY(0, 1);
    LCD_WriteString("Press TEST/RESET");
    while (KEY_PORT == 0);
    LCD_ClearDisplay();
    LCD_WriteString("Y Axis From HA5 ");
    SpiritLevel();
}

void main(void)
{
    init_timer0();
    while (1)
    {
        ErrorCount = 0;

        Hello();

        Standard_Character_Pattern_Test();

        ErrorLEDs(TestDipSwitches());

        ErrorLEDs(TestUserIO());

        CalibrateSpiritLevel();

        TestAccelerometerAxisXAlt();

        TestAccelerometerAxisYAlt();

        TestAccelerometerAxisXJpr();

        TestAccelerometerAxisYJpr();

        LCD_GotoXY(0, 1);
        LCD_WriteString("RESET To Restart");
        LCD_GotoXY(0, 0);
        if (ErrorCount == 0)
        {
            LCD_WriteString("  - SUCCESS -   ");
            while (KEY_PORT == 0);
        }
        else
        {
            LCD_WriteString("   - FAILED -   ");
            do
            {
                LED_PORT = 0xFF;
                Wait_1ms(50);
                LED_PORT = 0x00;
                Wait_1ms(50);
            } while (KEY_PORT == 0);
        }
    }
}

