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
// Simulation Library File for ORCA3
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/CD4P3JX_GSR.v,v 1.4 2005/05/19 18:29:24 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.0.1.1 on Fri Jun 24 11:42:29 1994 */
/* module compiled from "lsl2db 3.6.4" run */

module CD4P3JX_GSR (CI, SP, CK, PD, GSR, PUR, CO, Q0, Q1, Q2, Q3);
  parameter DISABLED_GSR = 0;
  input  CI, SP, CK, PD, GSR, PUR;
  output CO, Q0, Q1, Q2, Q3;
  reg n;
  reg SR;

//---- Programmable GSR ----

  always @ (GSR or PUR) begin
    if (DISABLED_GSR == 0) begin
      SR = GSR && PUR;
    end
    else if (DISABLED_GSR == 1)
      SR = PUR;
  end
//--------------------------
and INST11  (I4 , Q0 , CII  );
or INST12  (I6 , CII , I4 , Q0  );
xnor INST13  (I7 , Q0 , CII  );
and INST24  (I16 , Q1 , I6  );
or INST25  (I18 , I6 , I16 , Q1  );
xnor INST26  (I19 , Q1 , I6  );
and INST37  (I29 , Q2 , I18  );
or INST38  (I31 , I18 , I29 , Q2  );
xnor INST39  (I32 , Q2 , I18  );
and INST50  (I42 , Q3 , I31  );
or INST51  (CO , I31 , I42 , Q3  );
xnor INST52  (I45 , Q3 , I31  );
or \INST68.INST33  (\INST68.I50 , \INST68.I36 , \INST68.I73  );
and \INST68.INST34  (\INST68.I36 , Q0 , \INST68.I54  );
and \INST68.INST35  (\INST68.I73 , SP , \INST68.I68  );
not \INST68.INST52  (\INST68.I54 , SP  );
//UDFDL7 \INST68.INST6 (.D(\INST68.I50 ), .CK(CK), .PRE( \INST68.I29 ), .Q(Q0), .QN(\INST68.QN ));
UDFDL7_UDP_X \INST68.INST6 (Q0, \INST68.I50 , CK, \INST68.I29 , n);
or \INST68.INST67  (\INST68.I68 , I7 , PD  );
not \INST68.INST76  (\INST68.I29 , SR  );
or \INST69.INST33  (\INST69.I50 , \INST69.I36 , \INST69.I73  );
and \INST69.INST34  (\INST69.I36 , Q1 , \INST69.I54  );
and \INST69.INST35  (\INST69.I73 , SP , \INST69.I68  );
not \INST69.INST52  (\INST69.I54 , SP  );
//UDFDL7 \INST69.INST6 (.D(\INST69.I50 ), .CK(CK), .PRE( \INST69.I29 ), .Q(Q1), .QN(\INST69.QN ));
UDFDL7_UDP_X \INST69.INST6 (Q1, \INST69.I50 , CK, \INST69.I29 , n);
or \INST69.INST67  (\INST69.I68 , I19 , PD  );
not \INST69.INST76  (\INST69.I29 , SR  );
or \INST70.INST33  (\INST70.I50 , \INST70.I36 , \INST70.I73  );
and \INST70.INST34  (\INST70.I36 , Q2 , \INST70.I54  );
and \INST70.INST35  (\INST70.I73 , SP , \INST70.I68  );
not \INST70.INST52  (\INST70.I54 , SP  );
//UDFDL7 \INST70.INST6 (.D(\INST70.I50 ), .CK(CK), .PRE( \INST70.I29 ), .Q(Q2), .QN(\INST70.QN ));
UDFDL7_UDP_X \INST70.INST6 (Q2, \INST70.I50 , CK,  \INST70.I29 , n);
or \INST70.INST67  (\INST70.I68 , I32 , PD  );
not \INST70.INST76  (\INST70.I29 , SR  );
or \INST71.INST33  (\INST71.I50 , \INST71.I36 , \INST71.I73  );
and \INST71.INST34  (\INST71.I36 , Q3 , \INST71.I54  );
and \INST71.INST35  (\INST71.I73 , SP , \INST71.I68  );
not \INST71.INST52  (\INST71.I54 , SP  );
//UDFDL7 \INST71.INST6 (.D(\INST71.I50 ), .CK(CK), .PRE( \INST71.I29 ), .Q(Q3), .QN(\INST71.QN ));
UDFDL7_UDP_X \INST71.INST6 (Q3, \INST71.I50 , CK, \INST71.I29 , n);
or \INST71.INST67  (\INST71.I68 , I45 , PD  );
not \INST71.INST76  (\INST71.I29 , SR  );
or \INST999.INST33  (\INST999.I50 , \INST999.I36 , \INST999.I73  );
and \INST999.INST34  (\INST999.I36 , \INST999.Q , \INST999.I54  );
and \INST999.INST35  (\INST999.I73 , SP , \INST999.I68  );
not \INST999.INST52  (\INST999.I54 , SP  );
//UDFDL7 \INST999.INST6 (.D(\INST999.I50 ), .CK(CK), .PRE( \INST999.I29 ), .Q(\INST999.Q ), .QN(\INST999.QN ));
UDFDL7_UDP_X \INST999.INST6 (\INST999.Q ,\INST999.I50 , CK, \INST999.I29 , n);
or \INST999.INST67  (\INST999.I68 , CI , PD  );
not \INST999.INST76  (\INST999.I29 , SR  );
DELAY  INST990 (.A(CI), .Z(CII));


// For timing checks
not (PDN, PD);
and (GSR_PD, PDN, GSR);
and (PD_SP_CI_GSR, SP, PDN, CI, GSR);
and (GSR_CI_PD, PDN, CI, GSR);
and (GSR_CI, CI, GSR);


endmodule
