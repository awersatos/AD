-- $Id: dafir_pack_v7_0.vhd,v 1.15 2008/09/08 20:07:41 akennedy Exp $ This package contains constants used by the behavior model files
package dafir_pack_v7_0 is

  -- Vaules for c_response
  constant c_symmetric : integer := 0;
  constant c_non_symmetric : integer := 1;
  constant c_neg_symmetric : integer := 2;

  -- Values for c_data_type/c_coeff_type
  constant c_signed : integer := 0;
  constant c_unsigned : integer := 1;
  constant c_nrz : integer := 2;
 
  -- Values for c_filter_type 
  constant c_single_rate_fir : integer := 0;
  constant c_polyphase_interpolating : integer := 1;
  constant c_polyphase_decimating : integer := 2;
  constant c_hilbert_transform : integer := 3;
  constant c_interpolated_fir : integer := 4;
  constant c_half_band : integer := 5;
  constant c_decimating_half_band : integer := 6;
  constant c_interpolating_half_band : integer := 7;

  -- Values for c_reload
  constant c_no_reload : integer := 0;
  constant c_stop_during_reload : integer := 1;

end dafir_pack_v7_0;
