//Timer routines to generate accurate time delays on TSK51 processor

#define PROCESSOR_CLOCK      50000000
#define TEN_US_COUNT         12

void Wait_10us  (int Time);
void Wait_1ms   (int Time);
void Wait_1s    (int Time);

void init_timer0(void);

extern unsigned int  __data Time0;
extern unsigned char __data Time0_updated;
extern unsigned int  __data X_T2_Start;
extern unsigned int  __data X_T3;
extern unsigned int  __data X_T2;
extern unsigned int  __data X_T1;
extern unsigned int  __data ISR_T0Count;

