#  File: update_hardcopyiv_hssi.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library hardcopyiv_hssi for Altera
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw hardcopyiv_hssi
clearlibrary
acom -work hardcopyiv_hssi $OPT $DSN\src\hardcopyiv_hssi_components.vhd
acom -work hardcopyiv_hssi $OPT $DSN\src\hardcopyiv_hssi_atoms.vhd
setlibrarymode -ro hardcopyiv_hssi
