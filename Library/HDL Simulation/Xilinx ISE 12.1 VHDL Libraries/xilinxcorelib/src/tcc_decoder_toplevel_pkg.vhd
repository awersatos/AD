-------------------------------------------------------------------------------
PACKAGE tcc_decoder_toplevel_pkg IS

  FUNCTION TOPLEVEL_PKG_bits_needed_to_represent(a_value : INTEGER) RETURN INTEGER;

END tcc_decoder_toplevel_pkg;


--------------------------------------------------------------------------------
PACKAGE BODY tcc_decoder_toplevel_pkg IS

  --------------------------------------------------------------------------------
  -- Return number of bits required to represent the supplied parameter
  -- Returns 1 for values <= 0.
  --------------------------------------------------------------------------------
  FUNCTION TOPLEVEL_PKG_bits_needed_to_represent(a_value : INTEGER) RETURN INTEGER IS
    VARIABLE return_value : NATURAL := 1;
  BEGIN

    FOR i IN 30 DOWNTO 0 LOOP
      IF a_value >= 2**i THEN
        return_value := i+1;
        EXIT;
      END IF;
    END LOOP;

    RETURN return_value;

  END TOPLEVEL_PKG_bits_needed_to_represent;

END tcc_decoder_toplevel_pkg;

