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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/CD4P3IX_GSR.v,v 1.2 2005/05/19 19:00:58 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.0.1.1 on Fri Jun 24 11:42:26 1994 */
/* module compiled from "lsl2db 3.6.4" run */

module CD4P3IX_GSR (CI, SP, CK, CD, GSR, PUR, CO, Q0, Q1, Q2, Q3);
  parameter DISABLED_GSR = 0;
  input  CI, SP, CK, CD, GSR, PUR;
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
or \INST68.INST33  (\INST68.I50 , \INST68.I36 , \INST68.I38  );
and \INST68.INST34  (\INST68.I36 , Q0 , \INST68.I54  );
and \INST68.INST35  (\INST68.I38 , SP , \INST68.I65 , I7  );
not \INST68.INST52  (\INST68.I54 , SP  );
not \INST68.INST57  (\INST68.I65 , CD  );
//UDFDL5 \INST68.INST6 (.D(\INST68.I50 ), .CK(CK), .CLR( \INST68.I29 ), .Q(Q0), .QN(\INST68.QN ));
UDFDL5_UDP_X \INST68.INST6 (Q0, \INST68.I50 , CK,  \INST68.I29 , n);
not \INST68.INST69  (\INST68.I29 , SR  );
or \INST69.INST33  (\INST69.I50 , \INST69.I36 , \INST69.I38  );
and \INST69.INST34  (\INST69.I36 , Q1 , \INST69.I54  );
and \INST69.INST35  (\INST69.I38 , SP , \INST69.I65 , I19  );
not \INST69.INST52  (\INST69.I54 , SP  );
not \INST69.INST57  (\INST69.I65 , CD  );
//UDFDL5 \INST69.INST6 (.D(\INST69.I50 ), .CK(CK), .CLR( \INST69.I29 ), .Q(Q1), .QN(\INST69.QN ));
UDFDL5_UDP_X \INST69.INST6 (Q1, \INST69.I50 , CK, \INST69.I29 , n);
not \INST69.INST69  (\INST69.I29 , SR  );
or \INST70.INST33  (\INST70.I50 , \INST70.I36 , \INST70.I38  );
and \INST70.INST34  (\INST70.I36 , Q2 , \INST70.I54  );
and \INST70.INST35  (\INST70.I38 , SP , \INST70.I65 , I32  );
not \INST70.INST52  (\INST70.I54 , SP  );
not \INST70.INST57  (\INST70.I65 , CD  );
//UDFDL5 \INST70.INST6 (.D(\INST70.I50 ), .CK(CK), .CLR( \INST70.I29 ), .Q(Q2), .QN(\INST70.QN ));
UDFDL5_UDP_X \INST70.INST6 (Q2, \INST70.I50 , CK,  \INST70.I29 , n);
not \INST70.INST69  (\INST70.I29 , SR  );
or \INST71.INST33  (\INST71.I50 , \INST71.I36 , \INST71.I38  );
and \INST71.INST34  (\INST71.I36 , Q3 , \INST71.I54  );
and \INST71.INST35  (\INST71.I38 , SP , \INST71.I65 , I45  );
not \INST71.INST52  (\INST71.I54 , SP  );
not \INST71.INST57  (\INST71.I65 , CD  );
//UDFDL5 \INST71.INST6 (.D(\INST71.I50 ), .CK(CK), .CLR( \INST71.I29 ), .Q(Q3), .QN(\INST71.QN ));
UDFDL5_UDP_X \INST71.INST6 (Q3, \INST71.I50 , CK,  \INST71.I29 , n);
not \INST71.INST69  (\INST71.I29 , SR  );
or \INST999.INST33  (\INST999.I50 , \INST999.I36 , \INST999.I38  );
and \INST999.INST34  (\INST999.I36 , \INST999.Q , \INST999.I54  );
and \INST999.INST35  (\INST999.I38 , SP , \INST999.I65 , CI  );
not \INST999.INST52  (\INST999.I54 , SP  );
not \INST999.INST57  (\INST999.I65 , CD  );
//UDFDL5 \INST999.INST6 (.D(\INST999.I50 ), .CK(CK), .CLR( \INST999.I29 ), .Q(\INST999.Q ), .QN(\INST999.QN ));
UDFDL5_UDP_X \INST999.INST6 (\INST999.Q ,\INST999.I50 , CK, \INST999.I29 , n);
not \INST999.INST69  (\INST999.I29 , SR  );
DELAY  INST990 (.A(CI), .Z(CII));


// For timing checks
not (CDN, CD);
and (GSR_CD, CDN, GSR);
and (CD_SP_CI_GSR, SP, CDN, CI, GSR);
and (GSR_CI_CD, CDN, CI, GSR);
and (GSR_CI, CI, GSR);


endmodule

