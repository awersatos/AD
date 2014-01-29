#  File: update_lpm.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library lpm for Altera
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw lpm 
clearlibrary
acom -work lpm $OPT $DSN\src\220pack.vhd
acom -work lpm $OPT $DSN\src\220model.vhd
acom -work lpm $OPT $DSN\src\altera_mf_components.vhd 
acom -work lpm $OPT $DSN\src\altera_mf.vhd	  
setlibrarymode -ro lpm