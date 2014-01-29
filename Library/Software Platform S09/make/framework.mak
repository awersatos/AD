#
# Framework general makefile
#
# Always included from the embedded project's makefile.
# Note that 'SWPLATFORM' is defined in the embedded project's makefile.
# 

# Path definitions
 
SSASROOT     = $(SWPLATFORM) 
PLTFROOT     = $(SSASROOT)\platform
SERROOT      = $(SSASROOT)\services

SSASOUT      = frameout
SSASOUTDIR   = $(OUTDIR)\$(SSASOUT)

SSASCFG      = framecfg
SSASCFGDIR   = $(OUTDIR)\$(SSASCFG)

# compiler and assembler

CC  = $(PRODDIR)\c$(TARGET)\bin\cc$(TARGET)
ASM = $(PRODDIR)\c$(TARGET)\bin\as$(TARGET)


# 
# rules
#

# we need at least a dummy object
SSASOBJ =
SSASOBJ += "$(SSASOUTDIR)\dummy.obj"
"$(SSASOUTDIR)\dummy.obj" : "$(SSASROOT)\make\src\dummy.c"
    @echo Building Software Platform
    @"$(CC)" $(OPT_ARCH) $(OPT_CPU) $(OPT_CC_SSAS_LITE) $(OPT_CC) -c "$(SSASROOT)\make\src\dummy.c"  -o "$@"

# add framework lsl
OPT_LK = -d"$(SSASCFGDIR)\ssas.lsl" $(OPT_LK)

# include project specific generated makefile
include "$(SSASOUTDIR)\__framework.makefile"

# add a ssas cstart 
SSASOBJ += "$(SSASOUTDIR)\cstart.obj"
"$(SSASOUTDIR)\cstart.obj":
    @$(exist "$(SSASROOT)\make\src\c$(TARGET)\cstart.asm" "$(CC)" $(OPT_ARCH) $(OPT_CPU) $(OPT_CC_SSAS_LITE) $(OPT_CC) -c "$(SSASROOT)\make\src\c$(TARGET)\cstart.asm" -o "$@")
    @$(exist "$(SSASROOT)\make\src\c$(TARGET)\cstart.c"   "$(CC)" $(OPT_ARCH) $(OPT_CPU) $(OPT_CC_SSAS_LITE) $(OPT_CC) -c "$(SSASROOT)\make\src\c$(TARGET)\cstart.c" -o "$@")

# add a ssas exit to avoid dbg _exit call
SSASOBJ += "$(SSASOUTDIR)\exit.obj"
"$(SSASOUTDIR)\exit.obj":
    @$(exist "$(SSASROOT)\make\src\c$(TARGET)\exit.c"     "$(CC)" $(OPT_ARCH) $(OPT_CPU) $(OPT_CC_SSAS_LITE) $(OPT_CC) -c "$(SSASROOT)\make\src\c$(TARGET)\exit.c" -o "$@")

# build final software platform library
"$(SSASOUTDIR)\__framework.lib": $(SSASOBJ)
    "$(PRODDIR)\bin\tlb" -n -r "$@" -f << EOF
        $(separate "\n" $(SSASOBJ))
    EOF
    @echo Software platform built
