 -- $Header: /devl/xcs/repo/env/Databases/ip/src/com/xilinx/ip/iputils/simulation/iputils_family.vhd,v 1.12 2008/09/08 20:08:59 akennedy Exp $

 PACKAGE iputils_family IS

     CONSTANT any       : STRING := "any";
     CONSTANT x4k       : STRING := "x4k";
     CONSTANT x4ke      : STRING := "x4ke";
     CONSTANT x4kl      : STRING := "x4kl";
     CONSTANT x4kex     : STRING := "x4kex";
     CONSTANT x4kxl     : STRING := "x4kxl";
     CONSTANT x4kxv     : STRING := "x4kxv";
     CONSTANT x4kxla    : STRING := "x4kxla";
     CONSTANT spartan   : STRING := "spartan";
     CONSTANT spartanxl : STRING := "spartanxl";
     CONSTANT spartan2  : STRING := "spartan2";
     CONSTANT spartan2e : STRING := "spartan2e";
     CONSTANT virtex    : STRING := "virtex";
     CONSTANT virtexe   : STRING := "virtexe";
     CONSTANT virtex2   : STRING := "virtex2";
     CONSTANT virtex2p  : STRING := "virtex2p";
     CONSTANT spartan3  : STRING := "spartan3";
     CONSTANT spartan3e : STRING := "spartan3e";
     CONSTANT spartan3a : STRING := "spartan3a";
     CONSTANT aspartan3 : STRING := "aspartan3";
     CONSTANT virtex4   : STRING := "virtex4";
     CONSTANT virtex5   : STRING := "virtex5";
     CONSTANT qrvirtex  : STRING := "qrvirtex";
     CONSTANT qrvirtex2 : STRING := "qrvirtex2";
     CONSTANT qvirtex   : STRING := "qvirtex";
     CONSTANT qvirtex2  : STRING := "qvirtex2";
     CONSTANT qvirtexe  : STRING := "qvirtexe";

     FUNCTION derived ( child, ancestor : STRING ) RETURN BOOLEAN;

     FUNCTION equalIgnoreCase( str1, str2 : STRING ) RETURN BOOLEAN;

     FUNCTION toLowerCaseChar( char : CHARACTER ) RETURN CHARACTER;
      
 END iputils_family;

 PACKAGE BODY iputils_family IS

      -- True if architecture "child" is derived from, or equal to,
      -- the architecture "ancestor".
      -- ANY, X4K, SPARTAN, SPARTANXL
      -- ANY, X4K, X4KE, X4KL
      -- ANY, X4K, X4KEX, X4KXL, X4KXV, X4KXLA
      -- ANY, VIRTEX, SPARTAN2, SPARTAN2E
      -- ANY, VIRTEX, VIRTEXE
      -- ANY, VIRTEX, VIRTEX2, SPARTAN3, SPARTAN3E
      -- ANY, VIRTEX, VIRTEX2, SPARTAN3, SPARTAN3A
      -- ANY, VIRTEX, VIRTEX2, SPARTAN3, ASPARTAN3
      -- ANY, VIRTEX, VIRTEX2, VIRTEX2P
      -- ANY, VIRTEX, VIRTEX4
      -- ANY, VIRTEX, VIRTEX5

     FUNCTION derived ( child, ancestor : STRING ) RETURN BOOLEAN IS
         VARIABLE is_derived : BOOLEAN := FALSE;
     BEGIN
         IF equalIgnoreCase( child, virtex ) THEN
             IF ( equalIgnoreCase(ancestor,virtex) OR equalIgnoreCase(ancestor,any) ) THEN
                 is_derived := TRUE;
             END IF;
         ELSIF equalIgnoreCase( child, qvirtexe ) THEN
             IF ( equalIgnoreCase(ancestor,qvirtexe) OR equalIgnoreCase(ancestor,virtex) OR equalIgnoreCase(ancestor,any) ) THEN
                 is_derived := TRUE;
             END IF;
         ELSIF equalIgnoreCase( child, qvirtex2 ) THEN
             IF ( equalIgnoreCase(ancestor,qvirtex2) OR equalIgnoreCase(ancestor,virtex2) OR equalIgnoreCase(ancestor,virtex) OR equalIgnoreCase(ancestor,any) ) THEN
                 is_derived := TRUE;
             END IF;
         ELSIF equalIgnoreCase( child, qvirtex) THEN
             IF ( equalIgnoreCase(ancestor,qvirtex) OR equalIgnoreCase(ancestor,virtex) OR equalIgnoreCase(ancestor,any) ) THEN
                 is_derived := TRUE;
             END IF;
         ELSIF equalIgnoreCase( child, qrvirtex2 ) THEN
             IF ( equalIgnoreCase(ancestor,qrvirtex2) OR equalIgnoreCase(ancestor,virtex2) OR equalIgnoreCase(ancestor,virtex) OR equalIgnoreCase(ancestor,any) ) THEN
                 is_derived := TRUE;
             END IF;
         ELSIF equalIgnoreCase( child, qrvirtex ) THEN
             IF ( equalIgnoreCase(ancestor,qrvirtex) OR equalIgnoreCase(ancestor,virtex) OR equalIgnoreCase(ancestor,any) ) THEN
                 is_derived := TRUE;
             END IF;	     
         ELSIF equalIgnoreCase( child, virtex4 ) THEN
             IF ( equalIgnoreCase(ancestor,virtex4) OR equalIgnoreCase(ancestor,virtex) OR equalIgnoreCase(ancestor,any) ) THEN
                 is_derived := TRUE;
             END IF;
         ELSIF equalIgnoreCase( child, virtex5 ) THEN
             IF ( equalIgnoreCase(ancestor,virtex5) OR equalIgnoreCase(ancestor,virtex) OR equalIgnoreCase(ancestor,any) ) THEN
                 is_derived := TRUE;
             END IF;
         ELSIF equalIgnoreCase( child, virtex2 ) THEN
             IF ( equalIgnoreCase(ancestor,virtex2) OR equalIgnoreCase(ancestor,virtex) OR equalIgnoreCase(ancestor,any) ) THEN
                 is_derived := TRUE;
             END IF;
         ELSIF equalIgnoreCase( child, virtex2p ) THEN
             IF ( equalIgnoreCase(ancestor,virtex2p) OR equalIgnoreCase(ancestor,virtex2) OR equalIgnoreCase(ancestor,virtex) OR equalIgnoreCase(ancestor,any) ) THEN
                 is_derived := TRUE;
             END IF;
         ELSIF equalIgnoreCase( child, aspartan3 ) THEN
             IF ( equalIgnoreCase(ancestor,aspartan3) OR equalIgnoreCase(ancestor,spartan3) OR equalIgnoreCase(ancestor,virtex2) OR equalIgnoreCase(ancestor,virtex) OR equalIgnoreCase(ancestor,any) ) THEN
                 is_derived := TRUE;
             END IF;
         ELSIF equalIgnoreCase( child, spartan3a ) THEN
             IF ( equalIgnoreCase(ancestor,spartan3a) OR equalIgnoreCase(ancestor,spartan3) OR equalIgnoreCase(ancestor,virtex2) OR equalIgnoreCase(ancestor,virtex) OR equalIgnoreCase(ancestor,any) ) THEN
                 is_derived := TRUE;
             END IF;
         ELSIF equalIgnoreCase( child, spartan3e ) THEN
             IF ( equalIgnoreCase(ancestor,spartan3e) OR equalIgnoreCase(ancestor,spartan3) OR equalIgnoreCase(ancestor,virtex2) OR equalIgnoreCase(ancestor,virtex) OR equalIgnoreCase(ancestor,any) ) THEN
                 is_derived := TRUE;
             END IF;
         ELSIF equalIgnoreCase( child, spartan3 ) THEN
             IF ( equalIgnoreCase(ancestor,spartan3) OR equalIgnoreCase(ancestor,virtex2) OR equalIgnoreCase(ancestor,virtex) OR equalIgnoreCase(ancestor,any) ) THEN
                 is_derived := TRUE;
             END IF;
         ELSIF equalIgnoreCase( child, virtexe ) THEN
             IF ( equalIgnoreCase(ancestor,virtexe) OR equalIgnoreCase(ancestor,virtex) OR equalIgnoreCase(ancestor,any) ) THEN
                 is_derived := TRUE;
             END IF;
         ELSIF equalIgnoreCase( child, spartan2 ) THEN
             IF ( equalIgnoreCase(ancestor,spartan2) OR equalIgnoreCase(ancestor,virtex) OR equalIgnoreCase(ancestor,any) ) THEN
                 is_derived := TRUE;
             END IF;
         ELSIF equalIgnoreCase( child, spartan2e ) THEN
             IF ( equalIgnoreCase(ancestor,spartan2e) OR equalIgnoreCase(ancestor,spartan2) OR equalIgnoreCase(ancestor,virtex) OR equalIgnoreCase(ancestor,any) ) THEN
                 is_derived := TRUE;
             END IF;
         ELSIF equalIgnoreCase( child, x4k ) THEN
             IF ( equalIgnoreCase(ancestor,x4k) OR equalIgnoreCase(ancestor,any) ) THEN
                 is_derived := TRUE;
             END IF;
         ELSIF equalIgnoreCase( child, x4kex ) THEN
             IF ( equalIgnoreCase(ancestor,x4kex) OR equalIgnoreCase(ancestor,x4K) OR equalIgnoreCase(ancestor,any) ) THEN
                 is_derived := TRUE;
             END IF;
         ELSIF equalIgnoreCase( child, x4kxl ) THEN
             IF ( equalIgnoreCase(ancestor,x4kxl) OR equalIgnoreCase(ancestor,x4kex) OR equalIgnoreCase(ancestor,x4K) OR equalIgnoreCase(ancestor,any) ) THEN
                 is_derived := TRUE;
             END IF;
         ELSIF equalIgnoreCase( child, x4kxv ) THEN
             IF ( equalIgnoreCase(ancestor,x4kxv) OR equalIgnoreCase(ancestor,x4kxl) OR equalIgnoreCase(ancestor,x4kex) OR equalIgnoreCase(ancestor,x4K) OR equalIgnoreCase(ancestor,any) ) THEN
                 is_derived := TRUE;
             END IF;
         ELSIF equalIgnoreCase( child, x4kxla ) THEN
             IF ( equalIgnoreCase(ancestor,x4kxla) OR equalIgnoreCase(ancestor,x4kxv) OR equalIgnoreCase(ancestor,x4kxl) OR equalIgnoreCase(ancestor,x4kex) OR equalIgnoreCase(ancestor,x4K) OR equalIgnoreCase(ancestor,any) ) THEN
                 is_derived := TRUE;
             END IF;
         ELSIF equalIgnoreCase( child, x4ke ) THEN
             IF ( equalIgnoreCase(ancestor,x4ke) OR equalIgnoreCase(ancestor,x4K) OR equalIgnoreCase(ancestor,any) ) THEN
                 is_derived := TRUE;
             END IF;
         ELSIF equalIgnoreCase( child, x4kl ) THEN
             IF ( equalIgnoreCase(ancestor,x4kl) OR equalIgnoreCase(ancestor,x4ke) OR equalIgnoreCase(ancestor,x4K) OR equalIgnoreCase(ancestor,any) ) THEN
                 is_derived := TRUE;
             END IF;
         ELSIF equalIgnoreCase( child, spartan ) THEN
             IF ( equalIgnoreCase(ancestor,spartan) OR equalIgnoreCase(ancestor,x4k) OR equalIgnoreCase(ancestor,any) ) THEN
                 is_derived := TRUE;
             END IF;
         ELSIF equalIgnoreCase( child, spartanxl ) THEN
             IF ( equalIgnoreCase(ancestor,spartanxl) OR equalIgnoreCase(ancestor,spartan) OR equalIgnoreCase(ancestor,x4k) OR equalIgnoreCase(ancestor,any) ) THEN
                 is_derived := TRUE;
             END IF;
         ELSIF equalIgnoreCase( child, any ) THEN
             IF equalIgnoreCase( ancestor, any ) THEN
                 is_derived := TRUE;
             END IF;
         END IF;

         RETURN is_derived;
     END derived;


     -- Returns the lower case form of char if char is an upper case letter.
     -- Otherwise char is returned.
     FUNCTION toLowerCaseChar( char : CHARACTER ) RETURN CHARACTER IS
     BEGIN
        -- If char is not an upper case letter then return char
        IF char<'A' OR char>'Z' THEN
          RETURN char;
        END IF;
        -- Otherwise map char to its corresponding lower case character and
        -- return that
        CASE char IS
          WHEN 'A' => RETURN 'a'; WHEN 'B' => RETURN 'b'; WHEN 'C' => RETURN 'c'; WHEN 'D' => RETURN 'd';
          WHEN 'E' => RETURN 'e'; WHEN 'F' => RETURN 'f'; WHEN 'G' => RETURN 'g'; WHEN 'H' => RETURN 'h';
          WHEN 'I' => RETURN 'i'; WHEN 'J' => RETURN 'j'; WHEN 'K' => RETURN 'k'; WHEN 'L' => RETURN 'l';
          WHEN 'M' => RETURN 'm'; WHEN 'N' => RETURN 'n'; WHEN 'O' => RETURN 'o'; WHEN 'P' => RETURN 'p';
          WHEN 'Q' => RETURN 'q'; WHEN 'R' => RETURN 'r'; WHEN 'S' => RETURN 's'; WHEN 'T' => RETURN 't';
          WHEN 'U' => RETURN 'u'; WHEN 'V' => RETURN 'v'; WHEN 'W' => RETURN 'w'; WHEN 'X' => RETURN 'x';
          WHEN 'Y' => RETURN 'y'; WHEN 'Z' => RETURN 'z';
          WHEN OTHERS => RETURN char;
        END CASE;
     END toLowerCaseChar;
      

     -- Returns true if case insensitive string comparison determines that
     -- str1 and str2 are equal
     FUNCTION equalIgnoreCase( str1, str2 : STRING ) RETURN BOOLEAN IS
       CONSTANT len1 : INTEGER := str1'length;
       CONSTANT len2 : INTEGER := str2'length;
       VARIABLE equal : BOOLEAN := TRUE;
     BEGIN
        IF NOT (len1=len2) THEN
          equal := FALSE;
        ELSE
          FOR i IN str2'left TO str1'right LOOP
            IF NOT (toLowerCaseChar(str1(i)) = toLowerCaseChar(str2(i))) THEN
              equal := FALSE;
            END IF;
          END LOOP;
        END IF;

        RETURN equal;
     END equalIgnoreCase;
      
 END iputils_family;







