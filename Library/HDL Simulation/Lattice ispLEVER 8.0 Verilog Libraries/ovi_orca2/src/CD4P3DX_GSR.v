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
// Simulation Library File for ORCA2
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/CD4P3DX_GSR.v,v 1.2 2005/05/19 18:05:30 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.0.1.1 on Fri Jun 24 11:42:23 1994 */
/* module compiled from "lsl2db 3.6.4" run */

module CD4P3DX_GSR (CI, SP, CK, CD, GSR, CO, Q0, Q1, Q2, Q3);
input  CI, SP, CK, CD, GSR;
output CO, Q0, Q1, Q2, Q3;
reg n;
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
and \INST68.INST35  (\INST68.I38 , SP , I7  );
not \INST68.INST52  (\INST68.I54 , SP  );
or \INST68.INST59  (\INST68.I57 , \INST68.CDI , \INST68.I67  );
//UDFDL5 \INST68.INST6 (.D(\INST68.I50 ), .CK(CK), .CLR( \INST68.I57 ), .Q(Q0), .QN(\INST68.QN ));
UDFDL5_UDP_X \INST68.INST6 (Q0, \INST68.I50 , CK,  \INST68.I57 , n);
not \INST68.INST65  (\INST68.I67 , GSR  );
buf \INST68.INST997  (\INST68.CDI , CD  );
or \INST69.INST33  (\INST69.I50 , \INST69.I36 , \INST69.I38  );
and \INST69.INST34  (\INST69.I36 , Q1 , \INST69.I54  );
and \INST69.INST35  (\INST69.I38 , SP , I19  );
not \INST69.INST52  (\INST69.I54 , SP  );
or \INST69.INST59  (\INST69.I57 , \INST69.CDI , \INST69.I67  );
UDFDL5_UDP_X \INST69.INST6 (Q1, \INST69.I50 , CK,  \INST69.I57 , n);
not \INST69.INST65  (\INST69.I67 , GSR  );
buf \INST69.INST997  (\INST69.CDI , CD  );
or \INST70.INST33  (\INST70.I50 , \INST70.I36 , \INST70.I38  );
and \INST70.INST34  (\INST70.I36 , Q2 , \INST70.I54  );
and \INST70.INST35  (\INST70.I38 , SP , I32  );
not \INST70.INST52  (\INST70.I54 , SP  );
or \INST70.INST59  (\INST70.I57 , \INST70.CDI , \INST70.I67  );
UDFDL5_UDP_X \INST70.INST6 (Q2, \INST70.I50 , CK,  \INST70.I57 , n);
not \INST70.INST65  (\INST70.I67 , GSR  );
buf \INST70.INST997  (\INST70.CDI , CD  );
or \INST71.INST33  (\INST71.I50 , \INST71.I36 , \INST71.I38  );
and \INST71.INST34  (\INST71.I36 , Q3 , \INST71.I54  );
and \INST71.INST35  (\INST71.I38 , SP , I45  );
not \INST71.INST52  (\INST71.I54 , SP  );
or \INST71.INST59  (\INST71.I57 , \INST71.CDI , \INST71.I67  );
UDFDL5_UDP_X \INST71.INST6 (Q3, \INST71.I50 , CK,  \INST71.I57 , n);
not \INST71.INST65  (\INST71.I67 , GSR  );
buf \INST71.INST997  (\INST71.CDI , CD  );
or \INST999.INST33  (\INST999.I50 , \INST999.I36 , \INST999.I38  );
and \INST999.INST34  (\INST999.I36 , \INST999.Q , \INST999.I54  );
and \INST999.INST35  (\INST999.I38 , SP , CI  );
not \INST999.INST52  (\INST999.I54 , SP  );
or \INST999.INST59  (\INST999.I57 , \INST999.CDI , \INST999.I67  );
UDFDL5_UDP_X \INST999.INST6 ( \INST999.Q , \INST999.I50 , CK,  \INST999.I57 ,n);
not \INST999.INST65  (\INST999.I67 , GSR  );
 buf \INST999.INST997 (\INST999.CDI ,CD);
DELAY  INST990 (.A(CI), .Z(CII));


// For timing checks
not (CDN, CD);
and (GSR_CD, CDN, GSR);
and (CD_SP_CI_GSR, SP, CDN, CI, GSR);
and (GSR_CI_CD, CDN, CI, GSR);
and (GSR_CI, CI, GSR);


endmodule

