-- $Header: /devl/xcs/repo/env/Databases/ip/src2/I/ldpc_802_16_enc_v1_0/simulation/ldpc_802_16_enc_v1_0_xst_comp.vhd,v 1.8 2008/09/08 19:37:43 akennedy Exp $
--
--  Copyright(C) 2005 by Xilinx, Inc. All rights reserved.
--  This text/file contains proprietary, confidential
--  information of Xilinx, Inc., is distributed under license
--  from Xilinx, Inc., and may be used, copied and/or
--  disclosed only pursuant to the terms of a valid license
--  agreement with Xilinx, Inc.  Xilinx hereby grants you
--  a license to use this text/file solely for design, simulation,
--  implementation and creation of design files limited
--  to Xilinx devices or technologies. Use with non-Xilinx
--  devices or technologies is expressly prohibited and
--  immediately terminates your license unless covered by
--  a separate agreement.
--
--  Xilinx is providing this design, code, or information
--  "as is" solely for use in developing programs and
--  solutions for Xilinx devices.  By providing this design,
--  code, or information as one possible implementation of
--  this feature, application or standard, Xilinx is making no
--  representation that this implementation is free from any
--  claims of infringement.  You are responsible for
--  obtaining any rights you may require for your implementation.
--  Xilinx expressly disclaims any warranty whatsoever with
--  respect to the adequacy of the implementation, including
--  but not limited to any warranties or representations that this
--  implementation is free from claims of infringement, implied
--  warranties of merchantability or fitness for a particular
--  purpose.
--
--  Xilinx products are not intended for use in life support
--  appliances, devices, or systems. Use in such applications are
--  expressly prohibited.
--
--  This copyright and support notice must be retained as part
--  of this text at all times. (c) Copyright 1995-2005 Xilinx, Inc.
--  All rights reserved.

-------------------------------------------------------------------------------
-- Component statement for wrapper of behavioural model
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

package ldpc_802_16_enc_v1_0_xst_comp is

----------------------------------------------------------
-- Insert component declaration of top level xst file here
----------------------------------------------------------
  --core_if on component xst
  component ldpc_802_16_enc_v1_0_xst
    GENERIC (
      c_has_sclr : integer :=  0;
      c_has_ce : integer :=  0;
      c_has_1_2 : integer :=  1;
      c_has_2_3a : integer :=  1;
      c_has_2_3b : integer :=  1;
      c_has_3_4a : integer :=  1;
      c_has_3_4b : integer :=  1;
      c_has_5_6 : integer :=  1;
      c_max_block_size : integer :=  96;
      c_family : string :=  "virtex2p";
      c_elaboration_dir : string :=  ""
      );
    PORT (
      clk : in std_logic                    := '0';
      ce : in std_logic                    := '0';
      rate : in std_logic_vector(2 downto 0) := "000";
      block_size_sel : in std_logic_vector(4 downto 0) := "11000";
      sclr : in std_logic                    := '0';
      nd : in std_logic := '0';
      data_in : in std_logic := '0';
      fd_in : in std_logic := '0';
      rfd : out std_logic := '0';
      rffd : out std_logic := '0';
      rate_out : out std_logic_vector(2 downto 0) := "000";
      block_size_sel_out : out std_logic_vector(4 downto 0) := "00000";
      data_out : out std_logic                    := '0';
      cts : in std_logic                    := '0';
      rdy : out std_logic                    := '0';
      fd_out : out std_logic                    := '0'  
      );
  --core_if off
  END COMPONENT;


end ldpc_802_16_enc_v1_0_xst_comp;

