-- $Id: xcc_utils_v2_0.vhd,v 1.4 2009/12/04 11:46:20 akennedy Exp $
-------------------------------------------------------------------------------
--  (c) Copyright 1995-2006 Xilinx, Inc. All rights reserved.
--
--  This file contains confidential and proprietary information
--  of Xilinx, Inc. and is protected under U.S. and
--  international copyright and other intellectual property
--  laws.
--
--  DISCLAIMER
--  This disclaimer is not a license and does not grant any
--  rights to the materials distributed herewith. Except as
--  otherwise provided in a valid license issued to you by
--  Xilinx, and to the maximum extent permitted by applicable
--  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
--  WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
--  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
--  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
--  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
--  (2) Xilinx shall not be liable (whether in contract or tort,
--  including negligence, or under any other theory of
--  liability) for any loss or damage of any kind or nature
--  related to, arising under or in connection with these
--  materials, including for any direct, or any indirect,
--  special, incidental, or consequential loss or damage
--  (including loss of data, profits, goodwill, or any type of
--  loss or damage suffered as a result of any action brought
--  by a third party) even if such damage or loss was
--  reasonably foreseeable or Xilinx had been advised of the
--  possibility of the same.
--
--  CRITICAL APPLICATIONS
--  Xilinx products are not designed or intended to be fail-
--  safe, or for use in any application requiring fail-safe
--  performance, such as life-support or safety devices or
--  systems, Class III medical devices, nuclear facilities,
--  applications related to the deployment of airbags, or any
--  other applications that could lead to death, personal
--  injury, or severe property or environmental damage
--  (individually and collectively, "Critical
--  Applications"). Customer assumes the sole risk and
--  liability of any use of Xilinx products in Critical
--  Applications, subject only to applicable laws and
--  regulations governing limitations on product liability.
--
--  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
--  PART OF THIS FILE AT ALL TIMES. 
-------------------------------------------------------------------------------
--LIBRARY IEEE;
--USE IEEE.std_logic_1164.ALL;
--
--LIBRARY std;
--USE std.standard.ALL;
package xcc_utils_v2_0 is

  function sel_lines_reqd (
    p_width : integer)
    return integer;

end xcc_utils_v2_0;

package body xcc_utils_v2_0 is

  -- purpose: Returns the number of mux address lines needed to address a bus of the width input. Log2 rounded up
  --Note: deliberately returns 1 for width = 1 or 0, so that exception code is
  --not required for extremely small buses
  function sel_lines_reqd (
    p_width : integer)
    return integer is
    variable ret_val : integer := 0;
    variable max_bus : integer := 0;
  begin  -- sel_lines_reqd
    assert p_width >= 0 report "Illegal (negative) value input to sel_lines_reqd (xcc_utils)" severity ERROR;
    ret_val := 1;
    max_bus := 2;
    while ret_val < 1000 loop
      if max_bus >= p_width then
        return ret_val;
      end if;
      ret_val := ret_val +1;
      max_bus := max_bus + max_bus;     --*2, but + should be faster to execute.      
    end loop;
    return ret_val;                         --unnecessary, but silences an xst warning
  end sel_lines_reqd;

end xcc_utils_v2_0;
