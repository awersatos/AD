#  File: update_hardcopyiii.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library hardcopyiii for Altera
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw hardcopyiii
clearlibrary
acom -work hardcopyiii $OPT $DSN\src\hardcopyiii_atoms.vhd
acom -work hardcopyiii $OPT $DSN\src\hardcopyiii_components.vhd
setlibrarymode -ro hardcopyiii
