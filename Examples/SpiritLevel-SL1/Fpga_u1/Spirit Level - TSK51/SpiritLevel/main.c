#include "hware.h"
#include "LCD_Control.h"
#include "TimeTSK51.h"

#define SELECT_X_AXIS_ALT AXIS_PORT=0
#define SELECT_Y_AXIS_ALT AXIS_PORT=1

signed   long DelXAg;
signed   long DelYAg;
signed   long Ag;
signed   char AgDash;
signed   char sign;
signed   char Angle;

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
    SELECT_X_AXIS_ALT;
    DelXAg = GetDeltaAngle();

    SELECT_Y_AXIS_ALT;
    DelYAg = GetDeltaAngle();

    Wait_1ms(500);
}

void Hello(void)
{
    LCD_LIGHT = 0;
    InitLCD();
    LCD_LIGHT = 1;
    LCD_GotoXY(0, 0);
    LCD_WriteString("SpiritLevel V1.0");
    LCD_GotoXY(0, 1);
    LCD_WriteString("Press Test/Reset");
    Wait_1ms(500);

    while (KEY_PORT == 0);
}

void LCD_DisplayAngle(unsigned char ROW, signed long DelAg)
{
    while (Time0_updated < 11)
    {
        __asm("nop");
    }
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

    LCD_Set_DDRAM_Address(ROW + 12);
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

void SpiritLevel(void)
{                    
    LCD_GotoXY(0, 0);
    LCD_WriteString("X axis angle    ");
    LCD_GotoXY(0, 1);
    LCD_WriteString("Y axis angle    ");

    while (KEY_PORT == 0)
    {
        SELECT_X_AXIS_ALT;
        LCD_DisplayAngle(ROW0, DelXAg);

        SELECT_Y_AXIS_ALT;
        LCD_DisplayAngle(ROW1, DelYAg);
    }
}

void main(void)
{
    init_timer0();

    Hello();

    while (1)
    {

        CalibrateSpiritLevel();

        SpiritLevel();

    }
}

