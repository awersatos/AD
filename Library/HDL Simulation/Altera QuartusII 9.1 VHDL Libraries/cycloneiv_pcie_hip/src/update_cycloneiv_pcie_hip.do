#  File: update_cycloneiv_pcie_hip_pcie_hip.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library cycloneiv_pcie_hip for Altera
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw cycloneiv_pcie_hip
clearlibrary
acom -work cycloneiv_pcie_hip $OPT $DSN\src\cycloneiv_pcie_hip_components.vhd
acom -work cycloneiv_pcie_hip $OPT $DSN\src\cycloneiv_pcie_hip_atoms.vhd
setlibrarymode -ro cycloneiv_pcie_hip
