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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/DDR.v,v 1.4 2005/05/19 19:01:06 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module DDR (IND0, IND1, IND2, IND3, OUTD0, OUTD1, OUTD2, OUTD3, CK, 
              INQ0, INQ1, INQ2, INQ3, OUTQ0, OUTQ1, OUTQ2, OUTQ3);
  input  IND0, IND1, IND2, IND3, OUTD0, OUTD1, OUTD2, OUTD3, CK;
  output INQ0, INQ1, INQ2, INQ3, OUTQ0, OUTQ1, OUTQ2, OUTQ3;

  reg notifier_ind0;
  reg notifier_ind1;
  reg notifier_ind2;
  reg notifier_ind3;
  reg notifier_outd0;
  reg notifier_outd1;
  reg notifier_outd2;
  reg notifier_outd3;

  basicff INST0 (INQ0, CK, IND0, notifier_ind0);
  basicff INST1 (INQ1, CK, IND1, notifier_ind1);
  basicff INST2 (INQ2, CK, IND2, notifier_ind2);
  basicff INST3 (INQ3, CK, IND3, notifier_ind3);
  basicff INST4 (OUTQ0, CK, OUTD0, notifier_outd0);
  basicff INST5 (OUTQ1, CK, OUTD1, notifier_outd1);
  basicff INST6 (OUTQ2, CK, OUTD2, notifier_outd2);
  basicff INST7 (OUTQ3, CK, OUTD3, notifier_outd3);


endmodule

`endcelldefine


primitive basicff (q, ck, d, notifier);
  input ck, d, notifier;
  output q;
  reg q;

initial q=1'b0;

  table

    //   clk    d    notifier    q    qnew;
         (01)   0       ?    :   ?  :  0;
         (01)   1       ?    :   ?  :  1;
         (01)   x       ?    :   ?  :  x;
          ?    (??)     ?    :   ?  :  -;
         (?0)   ?       ?    :   ?  :  -;
          ?     ?       *    :   ?  :  x;

  endtable

endprimitive
