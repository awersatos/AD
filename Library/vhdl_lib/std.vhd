-- mm 2.0.0
package standard is
        type boolean is (false,true);
        type bit is ('0','1');
        type character is (NUL, SOH, STX, ETX, EOT, ENQ, ACK, BEL,
                           BS,  HT,  LF,  VT,  FF,  CR,  SO,  SI, 
                           DLE, DC1, DC2, DC3, DC4, NAK, SYN, ETB, 
                           CAN, EM,  SUB, ESC, FSP, GSP, RSP, USP, 
                           ' ', '!', '"', '#', '$', '%', '&', ''', 
                           '(', ')', '*', '+', ',', '-', '.', '/',
                           '0', '1', '2', '3', '4', '5', '6', '7',
                           '8', '9', ':', ';', '<', '=', '>', '?',
                           '@', 'A', 'B', 'C', 'D', 'E', 'F', 'G',
                           'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O',
                           'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W',
                           'X', 'Y', 'Z', '[', '\', ']', '^', '_',
                           '`', 'a', 'b', 'c', 'd', 'e', 'f', 'g',
                           'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
                           'p', 'q', 'r', 's', 't', 'u', 'v', 'w',
                           'x', 'y', 'z', '{', '|', '}', '~', DEL,
                           C128, C129, C130, C131, C132, C133, C134, C135, 
                           C136, C137, C138, C139, C140, C141, C142, C143, 
                           C144, C145, C146, C147, C148, C149, C150, C151, 
                           C152, C153, C154, C155, C156, C157, C158, C159, 
                           ' ', '¡', '¢', '£', '¤', '¥', '¦', '§', 
                           '¨', '©', 'ª', '«', '¬', '­', '®', '¯', 
                           '°', '±', '²', '³', '´', 'µ', '¶', '·', 
                           '¸', '¹', 'º', '»', '¼', '½', '¾', '¿', 
                           'À', 'Á', 'Â', 'Ã', 'Ä', 'Å', 'Æ', 'Ç', 
                           'È', 'É', 'Ê', 'Ë', 'Ì', 'Í', 'Î', 'Ï', 
                           'Ð', 'Ñ', 'Ò', 'Ó', 'Ô', 'Õ', 'Ö', '×', 
                           'Ø', 'Ù', 'Ú', 'Û', 'Ü', 'Ý', 'Þ', 'ß', 
                           'à', 'á', 'â', 'ã', 'ä', 'å', 'æ', 'ç', 
                           'è', 'é', 'ê', 'ë', 'ì', 'í', 'î', 'ï', 
                           'ð', 'ñ', 'ò', 'ó', 'ô', 'õ', 'ö', '÷', 
                           'ø', 'ù', 'ú', 'û', 'ü', 'ý', 'þ', 'ÿ');
        type severity_level is (note,warning,error,failure);
        type integer is range -2_147_483_647 to 2_147_483_647;
        type real    is range -2_147_483_647.0 to 2_147_483_647.0;
           
        type time    is range -2_147_483_647 to 2_147_483_647
           units
              fs;
              ps  = 1000 fs;
              ns  = 1000 ps;
              us  = 1000 ns;
              ms  = 1000 us;
              sec = 1000 ms;
              min = 60 sec;
              hr  = 60 min;
           end units;

	impure function now return time;

        subtype natural  is integer range 0 to integer'high;
        subtype positive is integer range 1 to integer'high;
           
        type string     is array (positive range <>) of character;
        type bit_vector is array (natural  range <>) of bit;

        attribute foreign : string;

end standard;

package body standard is
        -- Metamor , function 'now' always returns 0

        impure function now return time is
        begin
          return 0 fs;
        end;
end standard;


-- package textio is not supported by Metamor



