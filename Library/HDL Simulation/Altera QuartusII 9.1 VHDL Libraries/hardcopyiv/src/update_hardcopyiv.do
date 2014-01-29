#  File: update_hardcopyiv.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library hardcopyiv for Altera
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw hardcopyiv
clearlibrary
acom -work hardcopyiv $OPT $DSN\src\hardcopyiv_atoms.vhd
acom -work hardcopyiv $OPT $DSN\src\hardcopyiv_components.vhd
setlibrarymode -ro hardcopyiv
