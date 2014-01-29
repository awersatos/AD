/* colors according SVG 1.0, for paletted VGA driver */

#include <graphics.h>

#define __PRGB(I,R,G,B)        ((((R) & 0xFF) << 16) |       /* 8-bit red */      \
                                (((G) & 0xFF) <<  8) |       /* 8-bit green */    \
                                (((B) & 0xFF)      ))        /* 8-bit blue */


#define __black                __PRGB(  0,   0,   0,   0)
#define __white                __PRGB(  1, 255, 255, 255)
#define __red                  __PRGB(  2, 255,   0,   0)
#define __lime                 __PRGB(  3,   0, 255,   0)
#define __blue                 __PRGB(  4,   0,   0, 255)
#define __cyan                 __PRGB(  5,   0, 255, 255)
#define __magenta              __PRGB(  6, 255,   0, 255)
#define __yellow               __PRGB(  7, 255, 255,   0)
                                       
#define __gray                 __PRGB(  8, 128, 128, 128)
#define __silver               __PRGB(  9, 192, 192, 192)
#define __maroon               __PRGB( 10, 128,   0,   0)
#define __green                __PRGB( 11,   0, 128,   0)
#define __navy                 __PRGB( 12,   0,   0, 128)
#define __teal                 __PRGB( 13,   0, 128, 128)
#define __purple               __PRGB( 14, 128,   0, 128)
#define __olive                __PRGB( 15, 128, 128,   0)
                                       
/* red */                              
#define __indianred            __PRGB( 16, 205,  92,  92)
#define __lightcoral           __PRGB( 17, 240, 128, 128)
#define __salmon               __PRGB( 18, 250, 128, 114)
#define __darksalmon           __PRGB( 19, 233, 150, 122)
#define __lightsalmon          __PRGB( 20, 255, 160, 122)
#define __crimson              __PRGB( 21, 220,  20,  60)
#define __firebrick            __PRGB( 22, 178,  34,  34)
#define __darkred              __PRGB( 23, 139,   0,   0)
                                       
/* pink */                             
#define __pink                 __PRGB( 24, 255, 192, 203)
#define __lightpink            __PRGB( 25, 255, 182, 193)
#define __hotpink              __PRGB( 26, 255, 105, 180)
#define __deeppink             __PRGB( 27, 255,  20, 147)
#define __mediumvioletred      __PRGB( 28, 199,  21, 133)
#define __palevioletred        __PRGB( 29, 219, 112, 147)
                                       
/* orange */                           
#define __coral                __PRGB( 30, 255, 127,  80)
#define __tomato               __PRGB( 31, 255,  99,  71)
#define __orangered            __PRGB( 32, 255,  69,   0)
#define __darkorange           __PRGB( 33, 255, 140,   0)
#define __orange               __PRGB( 34, 255, 165,   0)
                                       
/* yellow */                           
#define __gold                 __PRGB( 35, 255, 215,   0)
#define __lightyellow          __PRGB( 36, 255, 255, 224)
#define __lemonchiffon         __PRGB( 37, 255, 250, 205)
#define __lightgoldenrodyellow __PRGB( 38, 250, 250, 210)
#define __papayawhip           __PRGB( 39, 255, 239, 213)
#define __moccasin             __PRGB( 40, 255, 228, 181)
#define __peachpuff            __PRGB( 41, 255, 218, 185)
#define __palegoldenrod        __PRGB( 42, 238, 232, 170)
#define __khaki                __PRGB( 43, 240, 230, 140)
#define __darkkhaki            __PRGB( 44, 189, 183, 107)
                                       
/* purple */                           
#define __lavender             __PRGB( 45, 230, 230, 250)
#define __thistle              __PRGB( 46, 216, 191, 216)
#define __plum                 __PRGB( 47, 221, 160, 221)
#define __violet               __PRGB( 48, 238, 130, 238)
#define __orchid               __PRGB( 49, 218, 112, 214)
#define __mediumorchid         __PRGB( 50, 186,  85, 211)
#define __mediumpurple         __PRGB( 51, 147, 112, 219)
#define __blueviolet           __PRGB( 52, 138,  43, 226)
#define __darkviolet           __PRGB( 53, 148,   0, 211)
#define __darkorchid           __PRGB( 54, 153,  50, 204)
#define __darkmagenta          __PRGB( 55, 139,   0, 139)
#define __indigo               __PRGB( 56,  75,   0, 130)
#define __slateblue            __PRGB( 57, 106,  90, 205)
#define __darkslateblue        __PRGB( 58,  72,  61, 139)
#define __mediumslateblue      __PRGB( 59, 123, 104, 238)
                                       
/* green */                            
#define __greenyellow          __PRGB( 60, 173, 255,  47)
#define __chartreuse           __PRGB( 61, 127, 255,   0)
#define __lawngreen            __PRGB( 62, 124, 252,   0)
#define __limegreen            __PRGB( 63,  50, 205,  50)
#define __palegreen            __PRGB( 64, 152, 251, 152)
#define __lightgreen           __PRGB( 65, 144, 238, 144)
#define __mediumspringgreen    __PRGB( 66,   0, 250, 154)
#define __springgreen          __PRGB( 67,   0, 255, 127)
#define __mediumseagreen       __PRGB( 68,  60, 179, 113)
#define __seagreen             __PRGB( 69,  46, 139,  87)
#define __forestgreen          __PRGB( 70,  34, 139,  34)
#define __darkgreen            __PRGB( 71,   0, 100,   0)
#define __yellowgreen          __PRGB( 72, 154, 205,  50)
#define __olivedrab            __PRGB( 73, 107, 142,  35)
#define __darkolivegreen       __PRGB( 74,  85, 107,  47)
#define __mediumaquamarine     __PRGB( 75, 102, 205, 170)
#define __darkseagreen         __PRGB( 76, 143, 188, 143)
#define __lightseagreen        __PRGB( 77,  32, 178, 170)
#define __darkcyan             __PRGB( 78,   0, 139, 139)
                                       
/* blue */                             
#define __lightcyan            __PRGB( 79, 224, 255, 255)
#define __paleturquoise        __PRGB( 80, 175, 238, 238)
#define __aquamarine           __PRGB( 81, 127, 255, 212)
#define __turquoise            __PRGB( 82,  64, 224, 208)
#define __mediumturquoise      __PRGB( 83,  72, 209, 204)
#define __darkturquoise        __PRGB( 84,   0, 206, 209)
#define __cadetblue            __PRGB( 85,  95, 158, 160)
#define __steelblue            __PRGB( 86,  70, 130, 180)
#define __lightsteelblue       __PRGB( 87, 176, 196, 222)
#define __powderblue           __PRGB( 88, 176, 224, 230)
#define __lightblue            __PRGB( 89, 173, 216, 230)
#define __skyblue              __PRGB( 90, 135, 206, 235)
#define __lightskyblue         __PRGB( 91, 135, 206, 250)
#define __deepskyblue          __PRGB( 92,   0, 191, 255)
#define __dodgerblue           __PRGB( 93,  30, 144, 255)
#define __cornflowerblue       __PRGB( 94, 100, 149, 237)
#define __royalblue            __PRGB( 95,  65, 105, 225)
#define __mediumblue           __PRGB( 96,   0,   0, 205)
#define __darkblue             __PRGB( 97,   0,   0, 139)
#define __midnightblue         __PRGB( 98,  25,  25, 112)
                                       
/* brown */                            
#define __cornsilk             __PRGB( 99, 255, 248, 220)
#define __blanchedalmond       __PRGB(100, 255, 235, 205)
#define __bisque               __PRGB(101, 255, 228, 196)
#define __navajowhite          __PRGB(102, 255, 222, 173)
#define __wheat                __PRGB(103, 245, 222, 179)
#define __burlywood            __PRGB(104, 222, 184, 135)
#define __tan                  __PRGB(105, 210, 180, 140)
#define __rosybrown            __PRGB(106, 188, 143, 143)
#define __sandybrown           __PRGB(107, 244, 164,  96)
#define __goldenrod            __PRGB(108, 218, 165,  32)
#define __darkgoldenrod        __PRGB(109, 184, 134,  11)
#define __peru                 __PRGB(110, 205, 133,  63)
#define __chocolate            __PRGB(111, 210, 105,  30)
#define __saddlebrown          __PRGB(112, 139,  69,  19)
#define __sienna               __PRGB(113, 160,  82,  45)
#define __brown                __PRGB(114, 165,  42,  42)
                                       
/* white */                            
#define __snow                 __PRGB(115, 255, 250, 250)
#define __honeydew             __PRGB(116, 240, 255, 240)
#define __mintcream            __PRGB(117, 245, 255, 250)
#define __azure                __PRGB(118, 240, 255, 255)
#define __aliceblue            __PRGB(119, 240, 248, 255)
#define __ghostwhite           __PRGB(120, 248, 248, 255)
#define __whitesmoke           __PRGB(121, 245, 245, 245)
#define __seashell             __PRGB(122, 255, 245, 238)
#define __beige                __PRGB(123, 245, 245, 220)
#define __oldlace              __PRGB(124, 253, 245, 230)
#define __floralwhite          __PRGB(125, 255, 250, 240)
#define __ivory                __PRGB(126, 255, 255, 240)
#define __antiquewhite         __PRGB(127, 250, 235, 215)
#define __linen                __PRGB(128, 250, 240, 230)
#define __lavenderblush        __PRGB(129, 255, 240, 245)
#define __mistyrose            __PRGB(130, 255, 228, 225)
                                       
/* grey */                             
#define __gainsboro            __PRGB(131, 220, 220, 220)
#define __lightgray            __PRGB(132, 211, 211, 211)
#define __darkgray             __PRGB(133, 169, 169, 169)
#define __dimgray              __PRGB(134, 105, 105, 105)
#define __lightslategray       __PRGB(135, 119, 136, 153)
#define __slategray            __PRGB(136, 112, 128, 144)
#define __darkslategray        __PRGB(137,  47,  79,  79)
                                       
/* gray scale 0-100% */                
#define __gray0                __PRGB(138,   0,   0,   0)  
#define __gray1                __PRGB(139,   3,   3,   3)  
#define __gray2                __PRGB(140,   5,   5,   5)  
#define __gray3                __PRGB(141,   8,   8,   8)  
#define __gray4                __PRGB(142,  10,  10,  10) 
#define __gray5                __PRGB(143,  13,  13,  13) 
#define __gray6                __PRGB(144,  15,  15,  15) 
#define __gray7                __PRGB(145,  18,  18,  18) 
#define __gray8                __PRGB(146,  20,  20,  20)
#define __gray9                __PRGB(147,  23,  23,  23) 
#define __gray10               __PRGB(148,  26,  26,  26) 
#define __gray11               __PRGB(149,  28,  28,  28) 
#define __gray12               __PRGB(150,  31,  31,  31) 
#define __gray13               __PRGB(151,  33,  33,  33) 
#define __gray14               __PRGB(152,  36,  36,  36) 
#define __gray15               __PRGB(153,  38,  38,  38) 
#define __gray16               __PRGB(154,  41,  41,  41) 
#define __gray17               __PRGB(155,  43,  43,  43) 
#define __gray18               __PRGB(156,  46,  46,  46) 
#define __gray19               __PRGB(157,  48,  48,  48) 
#define __gray20               __PRGB(158,  51,  51,  51) 
#define __gray21               __PRGB(159,  54,  54,  54) 
#define __gray22               __PRGB(160,  56,  56,  56) 
#define __gray23               __PRGB(161,  59,  59,  59) 
#define __gray24               __PRGB(162,  61,  61,  61) 
#define __gray25               __PRGB(163,  64,  64,  64) 
#define __gray26               __PRGB(164,  66,  66,  66) 
#define __gray27               __PRGB(165,  69,  69,  69) 
#define __gray28               __PRGB(166,  71,  71,  71) 
#define __gray29               __PRGB(167,  74,  74,  74) 
#define __gray30               __PRGB(168,  77,  77,  77) 
#define __gray31               __PRGB(169,  79,  79,  79) 
#define __gray32               __PRGB(170,  82,  82,  82) 
#define __gray33               __PRGB(171,  84,  84,  84) 
#define __gray34               __PRGB(172,  87,  87,  87) 
#define __gray35               __PRGB(173,  89,  89,  89) 
#define __gray36               __PRGB(174,  92,  92,  92) 
#define __gray37               __PRGB(175,  94,  94,  94) 
#define __gray38               __PRGB(176,  97,  97,  97) 
#define __gray39               __PRGB(177,  99,  99,  99) 
#define __gray40               __PRGB(178, 102, 102, 102) 
#define __gray41               __PRGB(179, 105, 105, 105) 
#define __gray42               __PRGB(180, 107, 107, 107) 
#define __gray43               __PRGB(181, 110, 110, 110) 
#define __gray44               __PRGB(182, 112, 112, 112) 
#define __gray45               __PRGB(183, 115, 115, 115) 
#define __gray46               __PRGB(184, 117, 117, 117) 
#define __gray47               __PRGB(185, 120, 120, 120) 
#define __gray48               __PRGB(186, 122, 122, 122) 
#define __gray49               __PRGB(187, 125, 125, 125) 
#define __gray50               __PRGB(188, 127, 127, 127) 
#define __gray51               __PRGB(189, 130, 130, 130) 
#define __gray52               __PRGB(190, 133, 133, 133) 
#define __gray53               __PRGB(191, 135, 135, 135) 
#define __gray54               __PRGB(192, 138, 138, 138) 
#define __gray55               __PRGB(193, 140, 140, 140) 
#define __gray56               __PRGB(194, 143, 143, 143)
#define __gray57               __PRGB(195, 145, 145, 145) 
#define __gray58               __PRGB(196, 148, 148, 148) 
#define __gray59               __PRGB(197, 150, 150, 150) 
#define __gray60               __PRGB(198, 153, 153, 153) 
#define __gray61               __PRGB(199, 156, 156, 156) 
#define __gray62               __PRGB(200, 158, 158, 158) 
#define __gray63               __PRGB(201, 161, 161, 161) 
#define __gray64               __PRGB(202, 163, 163, 163) 
#define __gray65               __PRGB(203, 166, 166, 166) 
#define __gray66               __PRGB(204, 168, 168, 168) 
#define __gray67               __PRGB(205, 171, 171, 171) 
#define __gray68               __PRGB(206, 173, 173, 173) 
#define __gray69               __PRGB(207, 176, 176, 176) 
#define __gray70               __PRGB(208, 179, 179, 179) 
#define __gray71               __PRGB(209, 181, 181, 181) 
#define __gray72               __PRGB(210, 184, 184, 184) 
#define __gray73               __PRGB(211, 186, 186, 186) 
#define __gray74               __PRGB(212, 189, 189, 189) 
#define __gray75               __PRGB(213, 191, 191, 191) 
#define __gray76               __PRGB(214, 194, 194, 194) 
#define __gray77               __PRGB(215, 196, 196, 196) 
#define __gray78               __PRGB(216, 199, 199, 199) 
#define __gray79               __PRGB(217, 201, 201, 201) 
#define __gray80               __PRGB(218, 204, 204, 204) 
#define __gray81               __PRGB(219, 207, 207, 207) 
#define __gray82               __PRGB(220, 209, 209, 209) 
#define __gray83               __PRGB(221, 212, 212, 212) 
#define __gray84               __PRGB(222, 214, 214, 214) 
#define __gray85               __PRGB(223, 217, 217, 217) 
#define __gray86               __PRGB(224, 219, 219, 219) 
#define __gray87               __PRGB(225, 222, 222, 222) 
#define __gray88               __PRGB(226, 224, 224, 224) 
#define __gray89               __PRGB(227, 227, 227, 227) 
#define __gray90               __PRGB(228, 229, 229, 229) 
#define __gray91               __PRGB(229, 232, 232, 232) 
#define __gray92               __PRGB(230, 235, 235, 235) 
#define __gray93               __PRGB(231, 237, 237, 237) 
#define __gray94               __PRGB(232, 240, 240, 240) 
#define __gray95               __PRGB(233, 242, 242, 242) 
#define __gray96               __PRGB(234, 245, 245, 245) 
#define __gray97               __PRGB(235, 247, 247, 247) 
#define __gray98               __PRGB(236, 250, 250, 250) 
#define __gray99               __PRGB(237, 252, 252, 252) 
#define __gray100              __PRGB(238, 255, 255, 255) 
 



color_t svg_colors[256] =
{
    __black,                
    __white,                
    __red,                  
    __lime,                 
    __blue,                 
    __cyan,                 
    __magenta,              
    __yellow,               
                                       
    __gray,                 
    __silver,               
    __maroon,               
    __green,                
    __navy,                 
    __teal,                 
    __purple,               
    __olive,                
                           
/* red */                  
    __indianred,            
    __lightcoral,           
    __salmon,               
    __darksalmon,           
    __lightsalmon,          
    __crimson,              
    __firebrick,            
    __darkred,              
                           
/* pink */                 
    __pink,                 
    __lightpink,            
    __hotpink,              
    __deeppink,             
    __mediumvioletred,      
    __palevioletred,        
                           
/* orange */               
    __coral,                
    __tomato,               
    __orangered,            
    __darkorange,           
    __orange,               
                           
/* yellow */               
    __gold,                 
    __lightyellow,          
    __lemonchiffon,         
    __lightgoldenrodyellow, 
    __papayawhip,           
    __moccasin,             
    __peachpuff,            
    __palegoldenrod,        
    __khaki,                
    __darkkhaki,            
                           
/* purple */               
    __lavender,             
    __thistle,              
    __plum,                 
    __violet,               
    __orchid,               
    __mediumorchid,         
    __mediumpurple,         
    __blueviolet,           
    __darkviolet,           
    __darkorchid,           
    __darkmagenta,          
    __indigo,               
    __slateblue,            
    __darkslateblue,        
    __mediumslateblue,      
                           
/* green */                
    __greenyellow,          
    __chartreuse,           
    __lawngreen,            
    __limegreen,            
    __palegreen,            
    __lightgreen,           
    __mediumspringgreen,    
    __springgreen,          
    __mediumseagreen,       
    __seagreen,             
    __forestgreen,          
    __darkgreen,            
    __yellowgreen,          
    __olivedrab,            
    __darkolivegreen,       
    __mediumaquamarine,     
    __darkseagreen,         
    __lightseagreen,        
    __darkcyan,             
                           
/* blue */                 
    __lightcyan,            
    __paleturquoise,        
    __aquamarine,           
    __turquoise,            
    __mediumturquoise,      
    __darkturquoise,        
    __cadetblue,            
    __steelblue,            
    __lightsteelblue,       
    __powderblue,           
    __lightblue,            
    __skyblue,              
    __lightskyblue,         
    __deepskyblue,          
    __dodgerblue,           
    __cornflowerblue,       
    __royalblue,            
    __mediumblue,           
    __darkblue,             
    __midnightblue,         
                           
/* brown */                
    __cornsilk,             
    __blanchedalmond,       
    __bisque,               
    __navajowhite,          
    __wheat,                
    __burlywood,            
    __tan,                  
    __rosybrown,            
    __sandybrown,           
    __goldenrod,            
    __darkgoldenrod,        
    __peru,                 
    __chocolate,            
    __saddlebrown,          
    __sienna,               
    __brown,                
                           
/* white */                
    __snow,                 
    __honeydew,             
    __mintcream,            
    __azure,                
    __aliceblue,            
    __ghostwhite,           
    __whitesmoke,           
    __seashell,             
    __beige,                
    __oldlace,              
    __floralwhite,          
    __ivory,                
    __antiquewhite,         
    __linen,                
    __lavenderblush,        
    __mistyrose,            
                           
/* grey */                 
    __gainsboro,            
    __lightgray,            
    __darkgray,             
    __dimgray,              
    __lightslategray,       
    __slategray,            
    __darkslategray,        
                           
/* gray scale 0-100% */    
    __gray0,                 
    __gray1,                 
    __gray2,                 
    __gray3,                 
    __gray4,                
    __gray5,                
    __gray6,                
    __gray7,                
    __gray8,                
    __gray9,                
    __gray10,               
    __gray11,               
    __gray12,               
    __gray13,               
    __gray14,               
    __gray15,               
    __gray16,               
    __gray17,               
    __gray18,               
    __gray19,               
    __gray20,               
    __gray21,               
    __gray22,               
    __gray23,               
    __gray24,               
    __gray25,               
    __gray26,               
    __gray27,               
    __gray28,               
    __gray29,               
    __gray30,               
    __gray31,               
    __gray32,               
    __gray33,               
    __gray34,               
    __gray35,               
    __gray36,               
    __gray37,               
    __gray38,               
    __gray39,               
    __gray40,               
    __gray41,               
    __gray42,               
    __gray43,               
    __gray44,               
    __gray45,               
    __gray46,               
    __gray47,               
    __gray48,               
    __gray49,               
    __gray50,               
    __gray51,               
    __gray52,               
    __gray53,               
    __gray54,               
    __gray55,               
    __gray56,               
    __gray57,               
    __gray58,               
    __gray59,               
    __gray60,               
    __gray61,               
    __gray62,               
    __gray63,               
    __gray64,               
    __gray65,               
    __gray66,               
    __gray67,               
    __gray68,               
    __gray69,               
    __gray70,               
    __gray71,               
    __gray72,               
    __gray73,               
    __gray74,               
    __gray75,               
    __gray76,               
    __gray77,               
    __gray78,               
    __gray79,               
    __gray80,               
    __gray81,               
    __gray82,               
    __gray83,               
    __gray84,               
    __gray85,               
    __gray86,               
    __gray87,               
    __gray88,               
    __gray89,               
    __gray90,               
    __gray91,               
    __gray92,               
    __gray93,               
    __gray94,               
    __gray95,               
    __gray96,               
    __gray97,               
    __gray98,               
    __gray99,               
    __gray100,              
};                                               
