////////////////////////////////////////////////////////////////////////////////
// HardwareDebug.h

#define HARDWARE_DEBUG 0

#if HARDWARE_DEBUG
void HDBG_Init(uint32_t testPort);
void HDBG_SetLeds(uint32_t value);
void HDBG_ClrLeds(uint32_t value);
#else
#define HDBG_Init(x)
#define HDBG_SetLeds(x)
#define HDBG_ClrLeds(x)
#endif











