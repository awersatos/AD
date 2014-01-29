// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Copyright (c) 2005-2008 by Lattice Semiconductor Corporation
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
// Simulation Library File for Block ROM PMI
//
// Parameter Definition
//Name                        Value                                    Default
/*
------------------------------------------------------------------------------
pmi_addr_depth              <integer>                                     512
pmi_addr_width              <integer>                                       9
pmi_data_width              <integer>                                      18
pmi_regmode               "reg"|"noreg"                                  "reg"
pmi_gsr                 "enable"|"disable"                           "disable"
pmi_resetmode             "async"|"sync"                                "sync"
pmi_optimization          "area"|"speed"                               "speed"
pmi_init_file               <string>                            valid mem file
pmi_init_file_format      "binary"|"hex"                              "binary"
pmi_family  "EC"|"XP"|"XP2"|"SC"|"SCM"|"ECP"|"ECP2"|"ECP2M"|"XO"|"ECP3"   "EC"
------------------------------------------------------------------------------
WARNING: Do not change the default parameters in this model. Parameter 
redefinition must be done using defparam or in-line (#) paramater 
redefinition in a top level file that instantiates this model.
 
*/
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/pmi/RCS/pmi_rom.v,v 1.5 2005/08/15 13:07:04 rag Exp $

`timescale 1ns/1ps
module pmi_rom
  #(parameter pmi_addr_depth = 512,
    parameter pmi_addr_width = 9,
    parameter pmi_data_width = 8,
    parameter pmi_regmode = "reg",
    parameter pmi_gsr = "disable",
    parameter pmi_resetmode = "sync",
    parameter pmi_optimization = "speed",
    parameter pmi_init_file = "none",
    parameter pmi_init_file_format = "binary",
    parameter pmi_family = "EC",
    parameter module_type = "pmi_rom")

   (input [(pmi_addr_width-1):0]	Address,
    input OutClock,
    input OutClockEn,
    input Reset,
    output [(pmi_data_width-1):0] Q)/*synthesis syn_black_box*/;

//pragma translate_off
   pmi_ram_dq #(.pmi_addr_depth(pmi_addr_depth),
		.pmi_addr_width(pmi_addr_width),
		.pmi_data_width(pmi_data_width),
		.pmi_regmode(pmi_regmode),
		.pmi_gsr(pmi_gsr),
		.pmi_resetmode(pmi_resetmode),
		.pmi_init_file(pmi_init_file),
		.pmi_init_file_format(pmi_init_file_format),
		.pmi_family(pmi_family))
   instpmi_ram_dq (
		   .Data({pmi_data_width{1'b0}}),
		   .Address(Address),
		   .Clock(OutClock),
		   .ClockEn(OutClockEn),
		   .WE(1'b0),
		   .Reset(Reset),
		   .Q(Q));

//pragma translate_on

endmodule    

