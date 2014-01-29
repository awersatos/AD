-------------------------------------------------------------------------------
-- $RCSfile: async_fifo_v5_1.vhd,v $ $Revision: 1.15 $ $Date: 2008/09/08 20:05:11 $
-------------------------------------------------------------------------------
--
-- Asynchronous FIFO v5_1 - VHDL Behavioral Model
--
-------------------------------------------------------------------------------
--                                                                       
--  Copyright(C) 2003 by Xilinx, Inc. All rights reserved.
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
----
--  Xilinx products are not intended for use in life support
--  appliances, devices, or systems. Use in such applications are
--  expressly prohibited.
---- Filename: async_fifo_v5_1.vhd
--  This copyright and support notice must be retained as part
--  of this text at all times. (c) Copyright 1995-2003 Xilinx, Inc.
--  All rights reserved.
--
-- Description: 
--  The behavioral model for the asynchronous fifo.
--                      
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- Library Declaration
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

-------------------------------------------------------------------------------
-- Entity Declaration
-------------------------------------------------------------------------------
ENTITY async_fifo_v5_1 IS
  
  -----------------------------------------------------------------------------
  -- Generic Declarations (alphabetical)
  -----------------------------------------------------------------------------
  GENERIC (
    c_data_width           : integer := 18;
    c_enable_rlocs         : integer := 0;
    c_fifo_depth           : integer := 520;
    c_has_almost_empty     : integer := 1;
    c_has_almost_full      : integer := 1;
    c_has_rd_ack	   : integer := 0;
    c_has_rd_count         : integer := 1;
    c_has_rd_err	   : integer := 0;
    c_has_wr_ack	   : integer := 0;
    c_has_wr_count         : integer := 1; 
    c_has_wr_err	   : integer := 0;            
    c_rd_ack_low	   : integer := 0;
    c_rd_count_width       : integer := 10;
    c_rd_err_low	   : integer := 0;
    c_use_blockmem         : integer := 1;
    c_wr_ack_low	   : integer := 0;
    c_wr_count_width       : integer := 10;
    c_wr_err_low	   : integer := 0   
    );
 
      
  PORT (
    -- Common Signals to both read and write sides
    DIN         : IN  STD_LOGIC_VECTOR(c_data_width - 1 DOWNTO 0);
    DOUT        : OUT STD_LOGIC_VECTOR(c_data_width - 1 DOWNTO 0):= (OTHERS => '0');
    AINIT       : IN  STD_LOGIC;
    
    -- Ports to the write side
    WR_EN       : IN  STD_LOGIC;
    WR_CLK      : IN  STD_LOGIC;
    FULL        : OUT STD_LOGIC;
    ALMOST_FULL : OUT STD_LOGIC;
    WR_ACK      : OUT STD_LOGIC;
    WR_ERR      : OUT STD_LOGIC;
    WR_COUNT    : OUT STD_LOGIC_VECTOR(c_wr_count_width - 1 DOWNTO 0);
    
    -- Ports to the read side
    RD_EN       : IN  STD_LOGIC;
    RD_CLK      : IN  STD_LOGIC;
    EMPTY       : OUT STD_LOGIC;
    ALMOST_EMPTY: OUT STD_LOGIC;
    RD_ACK      : OUT STD_LOGIC;
    RD_ERR      : OUT STD_LOGIC;
    RD_COUNT    : OUT STD_LOGIC_VECTOR(c_rd_count_width - 1 DOWNTO 0)
  );
END async_fifo_v5_1;
-------------------------------------------------------------------------------
-- Definition of Ports
-- DIN         : Input data bus for the fifo.
-- DOUT        : Output data bus for the fifo.
-- AINIT       : Asynchronous Reset for the fifo.
-- WR_EN       : Write enable signal.
-- WR_CLK      : Write Clock.
-- FULL        : Full signal.
-- ALMOST_FULL : One space left.
-- WR_ACK      : Last write acknowledged.
-- WR_ERR      : Last write rejected.
-- WR_COUNT    : Number of data words in fifo(synchronous to WR_CLK)
-- Rd_EN       : Read enable signal.
-- RD_CLK      : Read Clock.
-- EMPTY       : Empty signal.
-- ALMOST_EMPTY: One sapce left
-- RD_ACK      : Last read acknowledged.
-- RD_ERR      : Last read rejected.
-- RD_COUNT    : Number of data words in fifo(synchronous to RD_CLK)
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- Architecture Heading
-------------------------------------------------------------------------------
ARCHITECTURE behavioral OF async_fifo_v5_1 IS

  CONSTANT actual_depth : integer := c_fifo_depth;
  CONSTANT counter_depth : integer := c_fifo_depth + 1;
    
  SIGNAL wr_ack_active : STD_LOGIC := '1';  -- active sense of WR_ACK port
  SIGNAL wr_err_active : STD_LOGIC := '1';  -- active sense of WR_ERR port
  SIGNAL rd_ack_active : STD_LOGIC := '1';  -- active sense of RD_ACK port
  SIGNAL rd_err_active : STD_LOGIC := '1';  -- active sense of RD_ERR port
  SIGNAL wr_point : integer:= 0;
  SIGNAL rd_point : integer := 0;
  SIGNAL rd_reg0 : integer := 0;
  SIGNAL rd_reg1 : integer := 0;
  SIGNAL wr_reg0 : integer := 0;
  SIGNAL wr_reg1 : integer := 0;
  SIGNAL EMPTY_i : std_logic:= '0';
  SIGNAL FULL_i : std_logic := '0';
  
-------------------------------------------------------------------------------
-- Linked List types
-------------------------------------------------------------------------------
  type listtyp;
  type listptr is access listtyp;
  type listtyp is record
          data : std_logic_vector(c_data_width - 1 DOWNTO 0);
	  older : listptr;
	  newer : listptr;
  end record;
  

-------------------------------------------------------------------------------
-- Processes for linked list implementation
-------------------------------------------------------------------------------
  --Create a new linked list
  procedure newlist (head : inout listptr; tail : inout listptr) IS
  begin
    head := null;
    tail := null;
  end; -- procedure newlist;
	
  --Add a data element to a linked list
  procedure add (head : inout listptr; tail : inout listptr; data : in std_logic_vector) IS
    variable oldhead : listptr;
    variable newhead : listptr;
    begin
      --Create a pointer to the existing head, if applicable
      if (head /= null) then
        oldhead := head;
      end if;
      --Create a new node for the list
      newhead := new listtyp;
      --Make the new node point to the old head
      newhead.older := oldhead;
      --Make the old head point back to the new node (for doubly-linked list)
      if (head /= null) then
        oldhead.newer := newhead;
      end if;
      --Put the data into the new head node
      newhead.data := data;
      --If the new head we just created is the only node in the list, make the tail point to it
      if (newhead.older = null) then
	tail := newhead;
      end if;
      --Return the new head pointer
      head := newhead;
      end; -- procedure; -- add;
	
	
      --Read the data from the tail of the linked list
      procedure read (tail : inout listptr; data : out std_logic_vector) IS
      begin
        data := tail.data;
      end; -- procedure; -- read;
	
	
      --Remove the tail from the linked list
      procedure remove (head : inout listptr; tail : inout listptr) IS
        variable oldtail : listptr;
        variable newtail : listptr;
      begin
        --Make a copy of the old tail pointer
        oldtail := tail;
        --If there is no newer node, then set the tail pointer to nothing (list is empty)
        if (oldtail.newer=null) then
          newtail := null;
        --otherwise, make the next newer node the new tail, and make it point to nothing older
        else
          newtail := oldtail.newer;
          newtail.older := null;
        end if;
        --Clean up the memory for the old tail node
        DEALLOCATE(oldtail);
        --If the new tail is nothing, then we have an empty list, and head should also be set to nothing
        if (newtail=null) then
          head := null;
        end if;
        --Return the new tail
        tail := newtail;
      end; -- procedure; -- remove;
	
	
      --Calculate the size of the linked list
      procedure sizeof (head : inout listptr; size : out integer) IS
        variable curlink : listptr;
        variable tmpsize : integer := 0;
        begin	
          --If head is null, then there is nothing in the list to traverse
          if (head /= null) then	
            --start with the head node (which implies at least one node exists)
            curlink := head;
            tmpsize := 1;
            --Loop through each node until you find the one that points to nothing (the tail)
            while (curlink.older /= null) loop
              tmpsize := tmpsize + 1;  
              curlink := curlink.older;
            end loop;	
          end if;
          --Return the number of nodes
          size := tmpsize;
      end; -- procedure; -- sizeof;

      
  -- converts integer to std_logic_vector
  FUNCTION conv_to_std_logic_vector( arg : IN integer;
                                     size : IN integer
                                   ) RETURN std_logic_vector is
    VARIABLE result : std_logic_vector(size-1 DOWNTO 0);
    VARIABLE temp : integer;

  BEGIN

    temp := arg;
    FOR i IN 0 TO size-1 LOOP
      IF (temp MOD 2) = 1 THEN
        result(i) := '1';
      ELSE
        result(i) := '0';
      END IF;
      IF temp > 0 THEN
        temp := temp / 2;
      ELSE
        temp := (temp - 1) / 2;      
      END IF;
    END LOOP;  -- i
    
    RETURN result;
  END conv_to_std_logic_vector;      

  -- converts integer to specified length std_logic_vector : dropping least
  -- significant bits if integer is bigger than what can be represented by
  -- the vector
  FUNCTION count( fifo_count: IN integer;
                  fifo_depth: IN integer;
                  counter_width: IN integer
                ) RETURN std_logic_vector is
    VARIABLE temp : std_logic_vector(fifo_depth-1 DOWNTO 0) := (OTHERS => '0');
    VARIABLE output : std_logic_vector(counter_width - 1 DOWNTO 0):= (OTHERS => '0');
    VARIABLE power : integer := 1;
    VARIABLE bits : integer := 0;
    
  BEGIN

    WHILE power <= fifo_depth LOOP
      power := power * 2;
      bits := bits + 1;      
    END LOOP;
    temp := conv_to_std_logic_vector(fifo_count, fifo_depth);
    output := temp(bits - 1 DOWNTO bits - counter_width);
    RETURN output;
  END count;

-------------------------------------------------------------------------------
-- architecture begins here
-------------------------------------------------------------------------------
BEGIN

  FULL  <= FULL_i;
  EMPTY <= EMPTY_i;
-------------------------------------------------------------------------------  
-- Asynchrounous FIFO using linked lists
-------------------------------------------------------------------------------
  FIFO_PROC : PROCESS (WR_CLK, RD_CLK, AINIT)

    VARIABLE head : listptr;
    VARIABLE tail : listptr;
    VARIABLE size : integer := 0;
    VARIABLE data : std_logic_vector(c_data_width - 1 DOWNTO 0):= (OTHERS => '0');
    
  BEGIN

    --Determine polarity of ACK and ERR signals
    -- WR_ERR signal 
    IF c_wr_err_low = 1 THEN
      wr_err_active <= '0';
    ELSE
      wr_err_active <= '1';
    END IF;
    -- WR_ACK signal
    IF c_wr_ack_low = 1 THEN
      wr_ack_active <= '0';
    ELSE
      wr_ack_active <= '1';
    END IF;
    -- RD_ERR signal
    IF c_rd_err_low = 1 THEN
      rd_err_active <= '0';
    ELSE
      rd_err_active <= '1';
    END IF;
    -- RD_ACK signal
    IF c_rd_ack_low = 1 THEN
      rd_ack_active <= '0';
    ELSE
      rd_ack_active <= '1';
    END IF;
    
    -- RESET CONDITIONS
    IF AINIT = '1' THEN
      WR_ERR         <= NOT wr_err_active;
      WR_ACK         <= NOT wr_ack_active;
      WR_COUNT       <= (OTHERS => '0');
      FULL_i         <= '1';
      ALMOST_FULL    <= '1';
      
      wr_point        <= 0;
      rd_reg0   <= 0;
      rd_reg1   <= 0;
      
      --Create new linked list
      newlist(head, tail);
                 
    ---------------------------------------------------------------------------
    -- Write to FIFO
    ---------------------------------------------------------------------------
    ELSIF WR_CLK'event AND WR_CLK = '1' THEN

      sizeof(head, size);

      WR_ERR <= NOT wr_err_active;
      WR_ACK <= NOT wr_ack_active;

      --Default
      rd_reg0 <= rd_point;
      rd_reg1 <= rd_reg0;
      IF rd_reg1 = wr_point THEN
        WR_COUNT <= (OTHERS => '0');
      ELSIF rd_reg1 < wr_point THEN
        WR_COUNT <= count((wr_point - rd_reg1), c_fifo_depth, c_wr_count_width);
      ELSE
        WR_COUNT <= count((counter_depth-rd_reg1+wr_point), c_fifo_depth, c_wr_count_width);        
      END IF;
      
      IF size = actual_depth THEN
        FULL_i <= '1';
        ALMOST_FULL <= '1';
      ELSIF size = actual_depth - 1 THEN
        FULL_i <= '0';
        ALMOST_FULL <= '1';
      ELSE
        FULL_i <= '0';
        ALMOST_FULL <= '0';
      END IF;
      
      
      IF WR_EN = '1' THEN
        IF FULL_i /= '1'  THEN
          -- FIFO Full        
          IF size = actual_depth THEN
            WR_ERR <= wr_err_active;
          -- FIFO almost full
          ELSIF size + 1 = actual_depth THEN
            WR_ACK <= wr_ack_active;
            FULL_i <= '1';
            add(head, tail, DIN);
            wr_point <= (wr_point + 1) MOD counter_depth;
          -- one away from almost full
          ELSIF size + 2 = actual_depth THEN
            WR_ACK <= wr_ack_active;
            ALMOST_FULL <= '1';
            add(head, tail, DIN);
            wr_point <= (wr_point + 1) MOD counter_depth;
          ELSE
            WR_ACK <= wr_ack_active;
            add(head, tail, DIN); 
            wr_point <= (wr_point + 1) MOD counter_depth;
          END IF;
        ELSE
          WR_ERR <= wr_err_active;
        END IF;  
      END IF;
    END IF;  
    ---------------------------------------------------------------------------
    -- Read from FIFO
    ---------------------------------------------------------------------------
    IF AINIT = '1' THEN
      RD_ERR         <= NOT rd_err_active;
      RD_ACK         <= NOT rd_ack_active;
      RD_COUNT       <= (OTHERS => '0');
      EMPTY_i        <= '1';
      ALMOST_EMPTY   <= '1';
      
      rd_point        <= 0;
      wr_reg0   <= 0;
      wr_reg1   <= 0;

      
    ELSIF RD_CLK'event AND RD_CLK = '1' THEN

      sizeof(head, size);
     
      RD_ERR <= NOT rd_err_active;
      RD_ACK <= NOT rd_ack_active;

      --Default
      wr_reg0 <= wr_point;
      wr_reg1 <= wr_reg0;
      IF wr_reg1 = rd_point THEN
        RD_COUNT <= (OTHERS => '0');
      ELSIF wr_reg1 > rd_point THEN
        RD_COUNT <= count((wr_reg1 - rd_point), c_fifo_depth, c_rd_count_width);
      ELSE
        RD_COUNT <= count((counter_depth-rd_point+wr_reg1), c_fifo_depth, c_rd_count_width);        
      END IF;
      
      
      IF size = 0 THEN
        EMPTY_i <= '1';
        ALMOST_EMPTY <= '1';
      ELSIF size = 1 THEN
        EMPTY_i <= '0';
        ALMOST_EMPTY <= '1';
      ELSE
        EMPTY_i <= '0';
        ALMOST_EMPTY <= '0';       
      END IF;

      
      IF RD_EN = '1' THEN
        
        IF EMPTY_i /= '1' THEN
          -- FIFO full
          IF size = 2 THEN
            ALMOST_EMPTY <= '1';
            RD_ACK <= rd_ack_active;
            read(tail, data);
            remove(head, tail);
            rd_point <= (rd_point + 1) MOD counter_depth;
          -- almost empty
          ELSIF size = 1 THEN
            ALMOST_EMPTY <= '1';
            EMPTY_i <= '1';
            RD_ACK <= rd_ack_active;
            read(tail, data);
            remove(head, tail);
            rd_point <= (rd_point + 1) MOD counter_depth;
          -- fifo empty
          ELSIF size = 0 THEN
             RD_ERR <= rd_err_active;  
          -- middle counts
          ELSE
            RD_ACK <= rd_ack_active;
            read(tail, data);
            remove(head, tail);
            rd_point <= (rd_point + 1) MOD counter_depth;
          END IF;
        ELSE
          RD_ERR <= rd_err_active;
        END IF;  
      END IF;
    END IF;

    -- Place data read from linked list(FIFO) on the output bus
    DOUT <= data;
  END PROCESS;

  
END behavioral ;
