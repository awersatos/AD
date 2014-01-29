#  File: update_gdx2.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library gdx2 for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw gdx2 
clearlibrary
acom -work gdx2 $OPT $DSN\src\gdx2_components.vhd
acom -work gdx2 $OPT $DSN\src\gdx2.vhd
setlibrarymode -ro gdx2
