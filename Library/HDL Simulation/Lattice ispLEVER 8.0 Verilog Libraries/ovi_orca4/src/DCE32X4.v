// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Copyright (c) 2005 by Lattice Semiconductor Corporation
// --------------------------------------------------------------------
//
//
//                     Lattice Semiconductor Corporation
//                     5555 NE Moore Court
//                     Hillsboro, OR 97214
//                     U.S.A.
//
//                     TEL: 1-800-Lattice  (USA and Canada)
//                          1-408-826-6000 (other locations)
//
//                     web: http://www.latticesemi.com/
//                     email: techsupport@latticesemi.com
//
// --------------------------------------------------------------------
//
// Simulation Library File for ORCA4
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/DCE32X4.v,v 1.4 2005/05/19 19:01:05 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 10 ps

`celldefine

module DCE32X4 ( WAD0,WAD1,WAD2,WAD3,WAD4,DI0,DI1,DI2,DI3,CK,WREN,WPE0,WPE1,
                 RAD0,RAD1,RAD2,RAD3,RAD4,DO0,DO1,DO2,DO3,QDO0,QDO1,QDO2,QDO3);
 
  input WAD0,WAD1,WAD2,WAD3,WAD4,DI0,DI1,DI2,DI3,CK,WREN,WPE0,WPE1;
  input RAD0,RAD1,RAD2,RAD3,RAD4;
  output DO0,DO1,DO2,DO3,QDO0,QDO1,QDO2,QDO3;
  reg SRN;

  parameter [127:0] initval = 128'h00000000000000000000000000000000;
  parameter DISABLED_GSR = 0;

  defparam INST5.DISABLED_GSR = DISABLED_GSR;
  defparam INST5.init_value = initval;


  tri1 GSR = GSR_INST.GSRNET;
  tri1 PUR = PUR_INST.PURNET;

  SYN3RAM INST5 (DI3b,DI2b,DI1b,DI0b,WAD4b,WAD3b,WAD2b,WAD1b,WAD0b,WRENb, WPE0b, WPE1b,
                CKb,GSR,PUR,RAD4b,RAD3b,RAD2b,RAD1b,RAD0b,DO3b,DO2b,DO1b,DO0b,
                QDO3b,QDO2b,QDO1b,QDO0b);

  always @ (GSR or PUR ) begin
    if (DISABLED_GSR == 0) begin
      SRN = GSR & PUR ;
    end
    else if (DISABLED_GSR == 1)
      SRN = PUR;
  end

  not (SR, SRN);

  buf  (WAD0b, WAD0);
  buf  (WAD1b, WAD1);
  buf  (WAD2b, WAD2);
  buf  (WAD3b, WAD3);
  buf  (WAD4b, WAD4);
  buf  (DI0b, DI0);
  buf  (DI1b, DI1);
  buf  (DI2b, DI2);
  buf  (DI3b, DI3);
  buf  (CKb, CK);
  buf  (WRENb, WREN);
  buf  (WPE0b, WPE0);
  buf  (WPE1b, WPE1);
  buf  (RAD0b, RAD0);
  buf  (RAD1b, RAD1);
  buf  (RAD2b, RAD2);
  buf  (RAD3b, RAD3);
  buf  (RAD4b, RAD4);

  buf  (DO0, DO0b);
  buf  (DO1, DO1b);
  buf  (DO2, DO2b);
  buf  (DO3, DO3b);
  buf  (QDO0, QDO0b);
  buf  (QDO1, QDO1b);
  buf  (QDO2, QDO2b);
  buf  (QDO3, QDO3b);


endmodule
