//Timer routines to generate accurate time delays on TSK51 processor

#include <regtsk51a.sfr>
#include "TimeTSK51.h"

unsigned int  __data TempInt;
unsigned int  __data Time0;
unsigned char __data Time0_updated = 0;
unsigned int  __data LastCount = 0;
unsigned int  __data X_T2_Start = 0;
unsigned int  __data X_T3;
unsigned int  __data X_T2;
unsigned int  __data X_T1;
unsigned int  __data ISR_T0Count = 0;

void Wait_10us(int Time)
{
    for (int j = Time; j > 0; j--)
    {
        for (int i = TEN_US_COUNT; i > 0; i--)
        {
            __asm("nop");
        }
    }
}

void Wait_1ms(int Time)
{
    for (int i = Time; i > 0; i--)
    {
        Wait_10us(105);
    }
}

void Wait_1s(int Time)
{
    for (int i = Time; i > 0; i--)
    {
        Wait_1ms(1000);
    }
}

//Interrupt Service Routines etc.

/*
|<-------------T2------------>|<-------------T2------------>|<-------------T2------------>|<-------------T2------------>|
|<----T1---->|                |<----T1---->|                |<----T1---->|                |<----T1---->|

+------------+                +------------+                +------------+                +------------+
|            |                |            |                |            |                |            |
--+            +----------------+            +----------------+            +----------------+            +----------------+

Interrupt Point^                             ^                             ^                             ^
State          0                             1                             2                             0

Hardware Interrupt can only be set to trigger on falling edge.  Rising edge is best edge to measure T2 however
a reasonably accurate measurement of T2 can be made by measuring time between falling edges.

The ISR has 3 states:
0) Time the period between two sucessive falling edges to determine T2 (Timer is free running)
2) Time the duration of a high pulse - T1 (Timer is gated by hardware interrupt pin)
3) Idle - configure timer to be free running again and wait for next falling edge.
*/

void init_timer0(void)
{
    //Set up Timer0 and External Interrupt 0
    TMOD = (TMOD & 0xF0) | 0x01;                       //Not Gated, Timer Mode, 16-bit free running.
    // TMOD = 0x01;
    IT0 = 1;                                           //Interrupt on Falling edge.
    EX0 = 1;                                           //Enable External Interrupt.
    TR0 = 1;                                           //Set Timer 0 running
    EA  = 1;                                           //Enable Global Interrupts
}

__interrupt(0x03) void ExInt0(void)
{
    //Save Current Timer Count to variable 'TempInt'
    __asm("  mov _TempInt+1, TL0");
    __asm("  mov _TempInt, TH0");
    //Clear the timer register - rather than 0 use a value that indicates the instruction delay
    TL0 = 0;
    TH0 = 0;                                           // until this point in the code.
    TMOD ^= 0x08;                                      //Toggle between Gated and free running count

    if (TMOD & 0x08)                                   //Gate is now set so last measurement must have been for T2
    {
        X_T2 = TempInt;                                //TempInt holds the value of T0 at the time of this interrupt
    }
    else                                               //Gate is now clear so last measurement must have been for T3 (T3 = T2 - T1);
    {
        X_T3 = TempInt;
        if (X_T2)
        {
            X_T1 = X_T2 - X_T3;
        }
    }
    Time0_updated++;
    ISR_T0Count++;
    P2++;
}          
