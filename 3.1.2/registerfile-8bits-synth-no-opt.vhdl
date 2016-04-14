
library IEEE;

use IEEE.std_logic_1164.all;

package CONV_PACK_register_file_npower3_nbit8 is

-- define attributes
attribute ENUM_ENCODING : STRING;

end CONV_PACK_register_file_npower3_nbit8;

library IEEE;

use IEEE.std_logic_1164.all;

use work.CONV_PACK_register_file_npower3_nbit8.all;

entity register_file_npower3_nbit8 is

   port( CLK, RESET, ENABLE, RD1, RD2, WR : in std_logic;  ADD_WR, ADD_RD1, 
         ADD_RD2 : in std_logic_vector (2 downto 0);  DATAIN : in 
         std_logic_vector (7 downto 0);  OUT1, OUT2 : out std_logic_vector (7 
         downto 0));

end register_file_npower3_nbit8;

architecture SYN_A of register_file_npower3_nbit8 is

   component INV_X1
      port( A : in std_logic;  ZN : out std_logic);
   end component;
   
   component NAND2_X1
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component OAI22_X1
      port( A1, A2, B1, B2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component AOI221_X1
      port( B1, B2, C1, C2, A : in std_logic;  ZN : out std_logic);
   end component;
   
   component AND2_X1
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component OAI222_X1
      port( A1, A2, B1, B2, C1, C2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component AND3_X1
      port( A1, A2, A3 : in std_logic;  ZN : out std_logic);
   end component;
   
   component NAND3_X1
      port( A1, A2, A3 : in std_logic;  ZN : out std_logic);
   end component;
   
   component NOR2_X2
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component DFF_X1
      port( D, CK : in std_logic;  Q, QN : out std_logic);
   end component;
   
   signal REGISTERS_2_7_port, REGISTERS_2_6_port, REGISTERS_2_5_port, 
      REGISTERS_2_4_port, REGISTERS_2_3_port, REGISTERS_2_2_port, 
      REGISTERS_2_1_port, REGISTERS_2_0_port, REGISTERS_3_7_port, 
      REGISTERS_3_6_port, REGISTERS_3_5_port, REGISTERS_3_4_port, 
      REGISTERS_3_3_port, REGISTERS_3_2_port, REGISTERS_3_1_port, 
      REGISTERS_3_0_port, REGISTERS_6_7_port, REGISTERS_6_6_port, 
      REGISTERS_6_5_port, REGISTERS_6_4_port, REGISTERS_6_3_port, 
      REGISTERS_6_2_port, REGISTERS_6_1_port, REGISTERS_6_0_port, 
      REGISTERS_7_7_port, REGISTERS_7_6_port, REGISTERS_7_5_port, 
      REGISTERS_7_4_port, REGISTERS_7_3_port, REGISTERS_7_2_port, 
      REGISTERS_7_1_port, REGISTERS_7_0_port, n180, n181, n182, n183, n184, 
      n185, n186, n187, n188, n189, n190, n191, n192, n193, n194, n195, n196, 
      n197, n198, n199, n200, n201, n202, n203, n204, n205, n206, n207, n208, 
      n209, n210, n211, n212, n213, n214, n215, n216, n217, n218, n219, n220, 
      n221, n222, n223, n224, n225, n226, n227, n228, n229, n230, n231, n232, 
      n233, n234, n235, n236, n237, n238, n239, n240, n241, n242, n243, n244, 
      n245, n246, n247, n248, n249, n250, n251, n252, n253, n254, n255, n256, 
      n257, n258, n259, n260, n261, n262, n263, n264, n265, n266, n267, n268, 
      n269, n270, n271, n272, n273, n274, n275, n276, n277, n278, n279, n280, 
      n281, n282, n283, n284, n285, n286, n287, n288, n289, n290, n291, n292, 
      n293, n294, n295, n296, n297, n298, n299, n300, n301, n302, n303, n304, 
      n305, n306, n307, n308, n309, n310, n311, n312, n313, n314, n315, n316, 
      n317, n318, n319, n320, n321, n322, n323, n324, n325, n326, n327, n328, 
      n329, n330, n331, n332, n333, n334, n335, n336, n337, n338, n339, n340, 
      n341, n342, n343, n344, n345, n346, n347, n348, n349, n350, n351, n352, 
      n353, n354, n355, n356, n357, n358, n359, n360, n361, n362, n363, n364, 
      n365, n366, n367, n368, n369, n370, n371, n372, n373, n374, n375, n376, 
      n377, n378, n379, n380, n381, n382, n383, n384, n385, n386, n387, n388, 
      n389, n390, n391, n392, n393, n394, n395, n396, n397, n398, n399, n400, 
      n401, n402, n403, n404, n405, n406, n407, n408, n409, n410, n411, n412, 
      n413, n414, n415, n416, n417, n418, n419, n420, n421, n422, n423, n424, 
      n425, n426, n427, n428, n429, n430, n431, n432, n433, n434, n435, n436, 
      n437, n438, n439, n440, n441, n442, n443, n444, n445, n446, n447, n448, 
      n449, n450, n451, n452, n453, n454, n455, n456, n457, n458, n459, n460, 
      n461, n462, n463, n464, n465, n466, n467, n468, n469, n470, n471, n472, 
      n473, n474, n475, n476, n477, n478, n479, n480, n481, n482, n483 : 
      std_logic;

begin
   
   REGISTERS_reg_0_7_inst : DFF_X1 port map( D => n323, CK => CLK, Q => n340, 
                           QN => n243);
   REGISTERS_reg_0_6_inst : DFF_X1 port map( D => n322, CK => CLK, Q => n351, 
                           QN => n242);
   REGISTERS_reg_0_5_inst : DFF_X1 port map( D => n321, CK => CLK, Q => n353, 
                           QN => n241);
   REGISTERS_reg_0_4_inst : DFF_X1 port map( D => n320, CK => CLK, Q => n355, 
                           QN => n240);
   REGISTERS_reg_0_3_inst : DFF_X1 port map( D => n319, CK => CLK, Q => n342, 
                           QN => n239);
   REGISTERS_reg_0_2_inst : DFF_X1 port map( D => n318, CK => CLK, Q => n344, 
                           QN => n238);
   REGISTERS_reg_0_1_inst : DFF_X1 port map( D => n317, CK => CLK, Q => n346, 
                           QN => n237);
   REGISTERS_reg_0_0_inst : DFF_X1 port map( D => n316, CK => CLK, Q => n348, 
                           QN => n236);
   REGISTERS_reg_1_7_inst : DFF_X1 port map( D => n315, CK => CLK, Q => n362, 
                           QN => n235);
   REGISTERS_reg_1_6_inst : DFF_X1 port map( D => n314, CK => CLK, Q => n357, 
                           QN => n234);
   REGISTERS_reg_1_5_inst : DFF_X1 port map( D => n313, CK => CLK, Q => n359, 
                           QN => n233);
   REGISTERS_reg_1_4_inst : DFF_X1 port map( D => n312, CK => CLK, Q => n361, 
                           QN => n232);
   REGISTERS_reg_1_3_inst : DFF_X1 port map( D => n311, CK => CLK, Q => n364, 
                           QN => n231);
   REGISTERS_reg_1_2_inst : DFF_X1 port map( D => n310, CK => CLK, Q => n366, 
                           QN => n230);
   REGISTERS_reg_1_1_inst : DFF_X1 port map( D => n309, CK => CLK, Q => n368, 
                           QN => n229);
   REGISTERS_reg_1_0_inst : DFF_X1 port map( D => n308, CK => CLK, Q => n370, 
                           QN => n228);
   REGISTERS_reg_2_7_inst : DFF_X1 port map( D => n307, CK => CLK, Q => 
                           REGISTERS_2_7_port, QN => n338);
   REGISTERS_reg_2_6_inst : DFF_X1 port map( D => n306, CK => CLK, Q => 
                           REGISTERS_2_6_port, QN => n336);
   REGISTERS_reg_2_5_inst : DFF_X1 port map( D => n305, CK => CLK, Q => 
                           REGISTERS_2_5_port, QN => n334);
   REGISTERS_reg_2_4_inst : DFF_X1 port map( D => n304, CK => CLK, Q => 
                           REGISTERS_2_4_port, QN => n332);
   REGISTERS_reg_2_3_inst : DFF_X1 port map( D => n303, CK => CLK, Q => 
                           REGISTERS_2_3_port, QN => n330);
   REGISTERS_reg_2_2_inst : DFF_X1 port map( D => n302, CK => CLK, Q => 
                           REGISTERS_2_2_port, QN => n328);
   REGISTERS_reg_2_1_inst : DFF_X1 port map( D => n301, CK => CLK, Q => 
                           REGISTERS_2_1_port, QN => n326);
   REGISTERS_reg_2_0_inst : DFF_X1 port map( D => n300, CK => CLK, Q => 
                           REGISTERS_2_0_port, QN => n324);
   REGISTERS_reg_3_7_inst : DFF_X1 port map( D => n299, CK => CLK, Q => 
                           REGISTERS_3_7_port, QN => n339);
   REGISTERS_reg_3_6_inst : DFF_X1 port map( D => n298, CK => CLK, Q => 
                           REGISTERS_3_6_port, QN => n337);
   REGISTERS_reg_3_5_inst : DFF_X1 port map( D => n297, CK => CLK, Q => 
                           REGISTERS_3_5_port, QN => n335);
   REGISTERS_reg_3_4_inst : DFF_X1 port map( D => n296, CK => CLK, Q => 
                           REGISTERS_3_4_port, QN => n333);
   REGISTERS_reg_3_3_inst : DFF_X1 port map( D => n295, CK => CLK, Q => 
                           REGISTERS_3_3_port, QN => n331);
   REGISTERS_reg_3_2_inst : DFF_X1 port map( D => n294, CK => CLK, Q => 
                           REGISTERS_3_2_port, QN => n329);
   REGISTERS_reg_3_1_inst : DFF_X1 port map( D => n293, CK => CLK, Q => 
                           REGISTERS_3_1_port, QN => n327);
   REGISTERS_reg_3_0_inst : DFF_X1 port map( D => n292, CK => CLK, Q => 
                           REGISTERS_3_0_port, QN => n325);
   REGISTERS_reg_4_7_inst : DFF_X1 port map( D => n291, CK => CLK, Q => n350, 
                           QN => n227);
   REGISTERS_reg_4_6_inst : DFF_X1 port map( D => n290, CK => CLK, Q => n352, 
                           QN => n226);
   REGISTERS_reg_4_5_inst : DFF_X1 port map( D => n289, CK => CLK, Q => n354, 
                           QN => n225);
   REGISTERS_reg_4_4_inst : DFF_X1 port map( D => n288, CK => CLK, Q => n341, 
                           QN => n224);
   REGISTERS_reg_4_3_inst : DFF_X1 port map( D => n287, CK => CLK, Q => n343, 
                           QN => n223);
   REGISTERS_reg_4_2_inst : DFF_X1 port map( D => n286, CK => CLK, Q => n345, 
                           QN => n222);
   REGISTERS_reg_4_1_inst : DFF_X1 port map( D => n285, CK => CLK, Q => n347, 
                           QN => n221);
   REGISTERS_reg_4_0_inst : DFF_X1 port map( D => n284, CK => CLK, Q => n349, 
                           QN => n220);
   REGISTERS_reg_5_7_inst : DFF_X1 port map( D => n283, CK => CLK, Q => n356, 
                           QN => n219);
   REGISTERS_reg_5_6_inst : DFF_X1 port map( D => n282, CK => CLK, Q => n358, 
                           QN => n218);
   REGISTERS_reg_5_5_inst : DFF_X1 port map( D => n281, CK => CLK, Q => n360, 
                           QN => n217);
   REGISTERS_reg_5_4_inst : DFF_X1 port map( D => n280, CK => CLK, Q => n363, 
                           QN => n216);
   REGISTERS_reg_5_3_inst : DFF_X1 port map( D => n279, CK => CLK, Q => n365, 
                           QN => n215);
   REGISTERS_reg_5_2_inst : DFF_X1 port map( D => n278, CK => CLK, Q => n367, 
                           QN => n214);
   REGISTERS_reg_5_1_inst : DFF_X1 port map( D => n277, CK => CLK, Q => n369, 
                           QN => n213);
   REGISTERS_reg_5_0_inst : DFF_X1 port map( D => n276, CK => CLK, Q => n371, 
                           QN => n212);
   REGISTERS_reg_6_7_inst : DFF_X1 port map( D => n275, CK => CLK, Q => 
                           REGISTERS_6_7_port, QN => n211);
   REGISTERS_reg_6_6_inst : DFF_X1 port map( D => n274, CK => CLK, Q => 
                           REGISTERS_6_6_port, QN => n210);
   REGISTERS_reg_6_5_inst : DFF_X1 port map( D => n273, CK => CLK, Q => 
                           REGISTERS_6_5_port, QN => n209);
   REGISTERS_reg_6_4_inst : DFF_X1 port map( D => n272, CK => CLK, Q => 
                           REGISTERS_6_4_port, QN => n208);
   REGISTERS_reg_6_3_inst : DFF_X1 port map( D => n271, CK => CLK, Q => 
                           REGISTERS_6_3_port, QN => n207);
   REGISTERS_reg_6_2_inst : DFF_X1 port map( D => n270, CK => CLK, Q => 
                           REGISTERS_6_2_port, QN => n206);
   REGISTERS_reg_6_1_inst : DFF_X1 port map( D => n269, CK => CLK, Q => 
                           REGISTERS_6_1_port, QN => n205);
   REGISTERS_reg_6_0_inst : DFF_X1 port map( D => n268, CK => CLK, Q => 
                           REGISTERS_6_0_port, QN => n204);
   REGISTERS_reg_7_7_inst : DFF_X1 port map( D => n267, CK => CLK, Q => 
                           REGISTERS_7_7_port, QN => n203);
   REGISTERS_reg_7_6_inst : DFF_X1 port map( D => n266, CK => CLK, Q => 
                           REGISTERS_7_6_port, QN => n202);
   REGISTERS_reg_7_5_inst : DFF_X1 port map( D => n265, CK => CLK, Q => 
                           REGISTERS_7_5_port, QN => n201);
   REGISTERS_reg_7_4_inst : DFF_X1 port map( D => n264, CK => CLK, Q => 
                           REGISTERS_7_4_port, QN => n200);
   REGISTERS_reg_7_3_inst : DFF_X1 port map( D => n263, CK => CLK, Q => 
                           REGISTERS_7_3_port, QN => n199);
   REGISTERS_reg_7_2_inst : DFF_X1 port map( D => n262, CK => CLK, Q => 
                           REGISTERS_7_2_port, QN => n198);
   REGISTERS_reg_7_1_inst : DFF_X1 port map( D => n261, CK => CLK, Q => 
                           REGISTERS_7_1_port, QN => n197);
   REGISTERS_reg_7_0_inst : DFF_X1 port map( D => n260, CK => CLK, Q => 
                           REGISTERS_7_0_port, QN => n196);
   OUT2_reg_7_inst : DFF_X1 port map( D => n259, CK => CLK, Q => OUT2(7), QN =>
                           n195);
   OUT2_reg_6_inst : DFF_X1 port map( D => n258, CK => CLK, Q => OUT2(6), QN =>
                           n194);
   OUT2_reg_5_inst : DFF_X1 port map( D => n257, CK => CLK, Q => OUT2(5), QN =>
                           n193);
   OUT2_reg_4_inst : DFF_X1 port map( D => n256, CK => CLK, Q => OUT2(4), QN =>
                           n192);
   OUT2_reg_3_inst : DFF_X1 port map( D => n255, CK => CLK, Q => OUT2(3), QN =>
                           n191);
   OUT2_reg_2_inst : DFF_X1 port map( D => n254, CK => CLK, Q => OUT2(2), QN =>
                           n190);
   OUT2_reg_1_inst : DFF_X1 port map( D => n253, CK => CLK, Q => OUT2(1), QN =>
                           n189);
   OUT2_reg_0_inst : DFF_X1 port map( D => n252, CK => CLK, Q => OUT2(0), QN =>
                           n188);
   OUT1_reg_7_inst : DFF_X1 port map( D => n251, CK => CLK, Q => OUT1(7), QN =>
                           n187);
   OUT1_reg_6_inst : DFF_X1 port map( D => n250, CK => CLK, Q => OUT1(6), QN =>
                           n186);
   OUT1_reg_5_inst : DFF_X1 port map( D => n249, CK => CLK, Q => OUT1(5), QN =>
                           n185);
   OUT1_reg_4_inst : DFF_X1 port map( D => n248, CK => CLK, Q => OUT1(4), QN =>
                           n184);
   OUT1_reg_3_inst : DFF_X1 port map( D => n247, CK => CLK, Q => OUT1(3), QN =>
                           n183);
   OUT1_reg_2_inst : DFF_X1 port map( D => n246, CK => CLK, Q => OUT1(2), QN =>
                           n182);
   OUT1_reg_1_inst : DFF_X1 port map( D => n245, CK => CLK, Q => OUT1(1), QN =>
                           n181);
   OUT1_reg_0_inst : DFF_X1 port map( D => n244, CK => CLK, Q => OUT1(0), QN =>
                           n180);
   U261 : AOI221_X1 port map( B1 => n448, B2 => n361, C1 => n449, C2 => n355, A
                           => n464, ZN => n463);
   U262 : AOI221_X1 port map( B1 => n448, B2 => n360, C1 => n449, C2 => n354, A
                           => n461, ZN => n458);
   U263 : AOI221_X1 port map( B1 => n448, B2 => n359, C1 => n449, C2 => n353, A
                           => n460, ZN => n459);
   U264 : AOI221_X1 port map( B1 => n448, B2 => n358, C1 => n449, C2 => n352, A
                           => n457, ZN => n454);
   U265 : AOI221_X1 port map( B1 => n448, B2 => n357, C1 => n449, C2 => n351, A
                           => n456, ZN => n455);
   U266 : AOI221_X1 port map( B1 => n448, B2 => n356, C1 => n449, C2 => n350, A
                           => n453, ZN => n443);
   U267 : AOI221_X1 port map( B1 => n407, B2 => n361, C1 => n408, C2 => n355, A
                           => n423, ZN => n422);
   U268 : AOI221_X1 port map( B1 => n407, B2 => n360, C1 => n408, C2 => n354, A
                           => n420, ZN => n417);
   U269 : AOI221_X1 port map( B1 => n407, B2 => n359, C1 => n408, C2 => n353, A
                           => n419, ZN => n418);
   U270 : AOI221_X1 port map( B1 => n407, B2 => n358, C1 => n408, C2 => n352, A
                           => n416, ZN => n413);
   U271 : AOI221_X1 port map( B1 => n407, B2 => n357, C1 => n408, C2 => n351, A
                           => n415, ZN => n414);
   U272 : AOI221_X1 port map( B1 => n407, B2 => n356, C1 => n408, C2 => n350, A
                           => n412, ZN => n402);
   U273 : NOR2_X2 port map( A1 => n483, A2 => ADD_RD1(1), ZN => n448);
   U274 : NOR2_X2 port map( A1 => n442, A2 => ADD_RD2(1), ZN => n407);
   U275 : NOR2_X2 port map( A1 => ADD_RD1(0), A2 => ADD_RD1(1), ZN => n449);
   U276 : NOR2_X2 port map( A1 => ADD_RD2(0), A2 => ADD_RD2(1), ZN => n408);
   U277 : OAI22_X1 port map( A1 => n243, A2 => n372, B1 => n373, B2 => n374, ZN
                           => n323);
   U278 : OAI22_X1 port map( A1 => n242, A2 => n372, B1 => n373, B2 => n375, ZN
                           => n322);
   U279 : OAI22_X1 port map( A1 => n241, A2 => n372, B1 => n373, B2 => n376, ZN
                           => n321);
   U280 : OAI22_X1 port map( A1 => n240, A2 => n372, B1 => n373, B2 => n377, ZN
                           => n320);
   U281 : OAI22_X1 port map( A1 => n239, A2 => n372, B1 => n373, B2 => n378, ZN
                           => n319);
   U282 : OAI22_X1 port map( A1 => n238, A2 => n372, B1 => n373, B2 => n379, ZN
                           => n318);
   U283 : OAI22_X1 port map( A1 => n237, A2 => n372, B1 => n373, B2 => n380, ZN
                           => n317);
   U284 : OAI22_X1 port map( A1 => n236, A2 => n372, B1 => n373, B2 => n381, ZN
                           => n316);
   U285 : NAND2_X1 port map( A1 => n382, A2 => n373, ZN => n372);
   U286 : NAND3_X1 port map( A1 => n383, A2 => n384, A3 => n385, ZN => n373);
   U287 : OAI22_X1 port map( A1 => n235, A2 => n386, B1 => n374, B2 => n387, ZN
                           => n315);
   U288 : OAI22_X1 port map( A1 => n234, A2 => n386, B1 => n375, B2 => n387, ZN
                           => n314);
   U289 : OAI22_X1 port map( A1 => n233, A2 => n386, B1 => n376, B2 => n387, ZN
                           => n313);
   U290 : OAI22_X1 port map( A1 => n232, A2 => n386, B1 => n377, B2 => n387, ZN
                           => n312);
   U291 : OAI22_X1 port map( A1 => n231, A2 => n386, B1 => n378, B2 => n387, ZN
                           => n311);
   U292 : OAI22_X1 port map( A1 => n230, A2 => n386, B1 => n379, B2 => n387, ZN
                           => n310);
   U293 : OAI22_X1 port map( A1 => n229, A2 => n386, B1 => n380, B2 => n387, ZN
                           => n309);
   U294 : OAI22_X1 port map( A1 => n228, A2 => n386, B1 => n381, B2 => n387, ZN
                           => n308);
   U295 : NAND2_X1 port map( A1 => n382, A2 => n387, ZN => n386);
   U296 : NAND3_X1 port map( A1 => n385, A2 => n384, A3 => ADD_WR(0), ZN => 
                           n387);
   U297 : OAI22_X1 port map( A1 => n338, A2 => n388, B1 => n374, B2 => n389, ZN
                           => n307);
   U298 : OAI22_X1 port map( A1 => n336, A2 => n388, B1 => n375, B2 => n389, ZN
                           => n306);
   U299 : OAI22_X1 port map( A1 => n334, A2 => n388, B1 => n376, B2 => n389, ZN
                           => n305);
   U300 : OAI22_X1 port map( A1 => n332, A2 => n388, B1 => n377, B2 => n389, ZN
                           => n304);
   U301 : OAI22_X1 port map( A1 => n330, A2 => n388, B1 => n378, B2 => n389, ZN
                           => n303);
   U302 : OAI22_X1 port map( A1 => n328, A2 => n388, B1 => n379, B2 => n389, ZN
                           => n302);
   U303 : OAI22_X1 port map( A1 => n326, A2 => n388, B1 => n380, B2 => n389, ZN
                           => n301);
   U304 : OAI22_X1 port map( A1 => n324, A2 => n388, B1 => n381, B2 => n389, ZN
                           => n300);
   U305 : NAND2_X1 port map( A1 => n382, A2 => n389, ZN => n388);
   U306 : NAND3_X1 port map( A1 => n385, A2 => n383, A3 => ADD_WR(1), ZN => 
                           n389);
   U307 : OAI22_X1 port map( A1 => n339, A2 => n390, B1 => n374, B2 => n391, ZN
                           => n299);
   U308 : OAI22_X1 port map( A1 => n337, A2 => n390, B1 => n375, B2 => n391, ZN
                           => n298);
   U309 : OAI22_X1 port map( A1 => n335, A2 => n390, B1 => n376, B2 => n391, ZN
                           => n297);
   U310 : OAI22_X1 port map( A1 => n333, A2 => n390, B1 => n377, B2 => n391, ZN
                           => n296);
   U311 : OAI22_X1 port map( A1 => n331, A2 => n390, B1 => n378, B2 => n391, ZN
                           => n295);
   U312 : OAI22_X1 port map( A1 => n329, A2 => n390, B1 => n379, B2 => n391, ZN
                           => n294);
   U313 : OAI22_X1 port map( A1 => n327, A2 => n390, B1 => n380, B2 => n391, ZN
                           => n293);
   U314 : OAI22_X1 port map( A1 => n325, A2 => n390, B1 => n381, B2 => n391, ZN
                           => n292);
   U315 : NAND2_X1 port map( A1 => n382, A2 => n391, ZN => n390);
   U316 : NAND3_X1 port map( A1 => ADD_WR(0), A2 => n385, A3 => ADD_WR(1), ZN 
                           => n391);
   U317 : AND3_X1 port map( A1 => ENABLE, A2 => n392, A3 => WR, ZN => n385);
   U318 : INV_X1 port map( A => ADD_WR(2), ZN => n392);
   U319 : OAI22_X1 port map( A1 => n227, A2 => n393, B1 => n374, B2 => n394, ZN
                           => n291);
   U320 : OAI22_X1 port map( A1 => n226, A2 => n393, B1 => n375, B2 => n394, ZN
                           => n290);
   U321 : OAI22_X1 port map( A1 => n225, A2 => n393, B1 => n376, B2 => n394, ZN
                           => n289);
   U322 : OAI22_X1 port map( A1 => n224, A2 => n393, B1 => n377, B2 => n394, ZN
                           => n288);
   U323 : OAI22_X1 port map( A1 => n223, A2 => n393, B1 => n378, B2 => n394, ZN
                           => n287);
   U324 : OAI22_X1 port map( A1 => n222, A2 => n393, B1 => n379, B2 => n394, ZN
                           => n286);
   U325 : OAI22_X1 port map( A1 => n221, A2 => n393, B1 => n380, B2 => n394, ZN
                           => n285);
   U326 : OAI22_X1 port map( A1 => n220, A2 => n393, B1 => n381, B2 => n394, ZN
                           => n284);
   U327 : NAND2_X1 port map( A1 => n382, A2 => n394, ZN => n393);
   U328 : NAND3_X1 port map( A1 => n383, A2 => n384, A3 => n395, ZN => n394);
   U329 : OAI22_X1 port map( A1 => n219, A2 => n396, B1 => n374, B2 => n397, ZN
                           => n283);
   U330 : OAI22_X1 port map( A1 => n218, A2 => n396, B1 => n375, B2 => n397, ZN
                           => n282);
   U331 : OAI22_X1 port map( A1 => n217, A2 => n396, B1 => n376, B2 => n397, ZN
                           => n281);
   U332 : OAI22_X1 port map( A1 => n216, A2 => n396, B1 => n377, B2 => n397, ZN
                           => n280);
   U333 : OAI22_X1 port map( A1 => n215, A2 => n396, B1 => n378, B2 => n397, ZN
                           => n279);
   U334 : OAI22_X1 port map( A1 => n214, A2 => n396, B1 => n379, B2 => n397, ZN
                           => n278);
   U335 : OAI22_X1 port map( A1 => n213, A2 => n396, B1 => n380, B2 => n397, ZN
                           => n277);
   U336 : OAI22_X1 port map( A1 => n212, A2 => n396, B1 => n381, B2 => n397, ZN
                           => n276);
   U337 : NAND2_X1 port map( A1 => n382, A2 => n397, ZN => n396);
   U338 : NAND3_X1 port map( A1 => ADD_WR(0), A2 => n384, A3 => n395, ZN => 
                           n397);
   U339 : INV_X1 port map( A => ADD_WR(1), ZN => n384);
   U340 : OAI22_X1 port map( A1 => n211, A2 => n398, B1 => n374, B2 => n399, ZN
                           => n275);
   U341 : OAI22_X1 port map( A1 => n210, A2 => n398, B1 => n375, B2 => n399, ZN
                           => n274);
   U342 : OAI22_X1 port map( A1 => n209, A2 => n398, B1 => n376, B2 => n399, ZN
                           => n273);
   U343 : OAI22_X1 port map( A1 => n208, A2 => n398, B1 => n377, B2 => n399, ZN
                           => n272);
   U344 : OAI22_X1 port map( A1 => n207, A2 => n398, B1 => n378, B2 => n399, ZN
                           => n271);
   U345 : OAI22_X1 port map( A1 => n206, A2 => n398, B1 => n379, B2 => n399, ZN
                           => n270);
   U346 : OAI22_X1 port map( A1 => n205, A2 => n398, B1 => n380, B2 => n399, ZN
                           => n269);
   U347 : OAI22_X1 port map( A1 => n204, A2 => n398, B1 => n381, B2 => n399, ZN
                           => n268);
   U348 : NAND2_X1 port map( A1 => n382, A2 => n399, ZN => n398);
   U349 : NAND3_X1 port map( A1 => ADD_WR(1), A2 => n383, A3 => n395, ZN => 
                           n399);
   U350 : INV_X1 port map( A => ADD_WR(0), ZN => n383);
   U351 : OAI22_X1 port map( A1 => n203, A2 => n400, B1 => n374, B2 => n401, ZN
                           => n267);
   U352 : INV_X1 port map( A => DATAIN(7), ZN => n374);
   U353 : OAI22_X1 port map( A1 => n202, A2 => n400, B1 => n375, B2 => n401, ZN
                           => n266);
   U354 : INV_X1 port map( A => DATAIN(6), ZN => n375);
   U355 : OAI22_X1 port map( A1 => n201, A2 => n400, B1 => n376, B2 => n401, ZN
                           => n265);
   U356 : INV_X1 port map( A => DATAIN(5), ZN => n376);
   U357 : OAI22_X1 port map( A1 => n200, A2 => n400, B1 => n377, B2 => n401, ZN
                           => n264);
   U358 : INV_X1 port map( A => DATAIN(4), ZN => n377);
   U359 : OAI22_X1 port map( A1 => n199, A2 => n400, B1 => n378, B2 => n401, ZN
                           => n263);
   U360 : INV_X1 port map( A => DATAIN(3), ZN => n378);
   U361 : OAI22_X1 port map( A1 => n198, A2 => n400, B1 => n379, B2 => n401, ZN
                           => n262);
   U362 : INV_X1 port map( A => DATAIN(2), ZN => n379);
   U363 : OAI22_X1 port map( A1 => n197, A2 => n400, B1 => n380, B2 => n401, ZN
                           => n261);
   U364 : INV_X1 port map( A => DATAIN(1), ZN => n380);
   U365 : OAI22_X1 port map( A1 => n196, A2 => n400, B1 => n381, B2 => n401, ZN
                           => n260);
   U366 : INV_X1 port map( A => DATAIN(0), ZN => n381);
   U367 : NAND2_X1 port map( A1 => n382, A2 => n401, ZN => n400);
   U368 : NAND3_X1 port map( A1 => ADD_WR(1), A2 => ADD_WR(0), A3 => n395, ZN 
                           => n401);
   U369 : AND3_X1 port map( A1 => WR, A2 => ENABLE, A3 => ADD_WR(2), ZN => n395
                           );
   U370 : INV_X1 port map( A => RESET, ZN => n382);
   U371 : OAI222_X1 port map( A1 => n402, A2 => n403, B1 => n404, B2 => n405, 
                           C1 => n195, C2 => n406, ZN => n259);
   U372 : AOI221_X1 port map( B1 => n407, B2 => n362, C1 => n408, C2 => n340, A
                           => n409, ZN => n404);
   U373 : OAI22_X1 port map( A1 => n339, A2 => n410, B1 => n338, B2 => n411, ZN
                           => n409);
   U374 : OAI22_X1 port map( A1 => n203, A2 => n410, B1 => n211, B2 => n411, ZN
                           => n412);
   U375 : OAI222_X1 port map( A1 => n413, A2 => n403, B1 => n414, B2 => n405, 
                           C1 => n194, C2 => n406, ZN => n258);
   U376 : OAI22_X1 port map( A1 => n337, A2 => n410, B1 => n336, B2 => n411, ZN
                           => n415);
   U377 : OAI22_X1 port map( A1 => n202, A2 => n410, B1 => n210, B2 => n411, ZN
                           => n416);
   U378 : OAI222_X1 port map( A1 => n417, A2 => n403, B1 => n418, B2 => n405, 
                           C1 => n193, C2 => n406, ZN => n257);
   U379 : OAI22_X1 port map( A1 => n335, A2 => n410, B1 => n334, B2 => n411, ZN
                           => n419);
   U380 : OAI22_X1 port map( A1 => n201, A2 => n410, B1 => n209, B2 => n411, ZN
                           => n420);
   U381 : OAI222_X1 port map( A1 => n421, A2 => n403, B1 => n422, B2 => n405, 
                           C1 => n192, C2 => n406, ZN => n256);
   U382 : OAI22_X1 port map( A1 => n333, A2 => n410, B1 => n332, B2 => n411, ZN
                           => n423);
   U383 : AOI221_X1 port map( B1 => n407, B2 => n363, C1 => n408, C2 => n341, A
                           => n424, ZN => n421);
   U384 : OAI22_X1 port map( A1 => n200, A2 => n410, B1 => n208, B2 => n411, ZN
                           => n424);
   U385 : OAI222_X1 port map( A1 => n425, A2 => n403, B1 => n426, B2 => n405, 
                           C1 => n191, C2 => n406, ZN => n255);
   U386 : AOI221_X1 port map( B1 => n407, B2 => n364, C1 => n408, C2 => n342, A
                           => n427, ZN => n426);
   U387 : OAI22_X1 port map( A1 => n331, A2 => n410, B1 => n330, B2 => n411, ZN
                           => n427);
   U388 : AOI221_X1 port map( B1 => n407, B2 => n365, C1 => n408, C2 => n343, A
                           => n428, ZN => n425);
   U389 : OAI22_X1 port map( A1 => n199, A2 => n410, B1 => n207, B2 => n411, ZN
                           => n428);
   U390 : OAI222_X1 port map( A1 => n429, A2 => n403, B1 => n430, B2 => n405, 
                           C1 => n190, C2 => n406, ZN => n254);
   U391 : AOI221_X1 port map( B1 => n407, B2 => n366, C1 => n408, C2 => n344, A
                           => n431, ZN => n430);
   U392 : OAI22_X1 port map( A1 => n329, A2 => n410, B1 => n328, B2 => n411, ZN
                           => n431);
   U393 : AOI221_X1 port map( B1 => n407, B2 => n367, C1 => n408, C2 => n345, A
                           => n432, ZN => n429);
   U394 : OAI22_X1 port map( A1 => n198, A2 => n410, B1 => n206, B2 => n411, ZN
                           => n432);
   U395 : OAI222_X1 port map( A1 => n433, A2 => n403, B1 => n434, B2 => n405, 
                           C1 => n189, C2 => n406, ZN => n253);
   U396 : AOI221_X1 port map( B1 => n407, B2 => n368, C1 => n408, C2 => n346, A
                           => n435, ZN => n434);
   U397 : OAI22_X1 port map( A1 => n327, A2 => n410, B1 => n326, B2 => n411, ZN
                           => n435);
   U398 : AOI221_X1 port map( B1 => n407, B2 => n369, C1 => n408, C2 => n347, A
                           => n436, ZN => n433);
   U399 : OAI22_X1 port map( A1 => n197, A2 => n410, B1 => n205, B2 => n411, ZN
                           => n436);
   U400 : OAI222_X1 port map( A1 => n437, A2 => n403, B1 => n438, B2 => n405, 
                           C1 => n188, C2 => n406, ZN => n252);
   U401 : NAND2_X1 port map( A1 => n406, A2 => n439, ZN => n405);
   U402 : INV_X1 port map( A => ADD_RD2(2), ZN => n439);
   U403 : AOI221_X1 port map( B1 => n407, B2 => n370, C1 => n408, C2 => n348, A
                           => n440, ZN => n438);
   U404 : OAI22_X1 port map( A1 => n325, A2 => n410, B1 => n324, B2 => n411, ZN
                           => n440);
   U405 : NAND2_X1 port map( A1 => ADD_RD2(2), A2 => n406, ZN => n403);
   U406 : AND2_X1 port map( A1 => RD2, A2 => ENABLE, ZN => n406);
   U407 : AOI221_X1 port map( B1 => n407, B2 => n371, C1 => n408, C2 => n349, A
                           => n441, ZN => n437);
   U408 : OAI22_X1 port map( A1 => n196, A2 => n410, B1 => n204, B2 => n411, ZN
                           => n441);
   U409 : NAND2_X1 port map( A1 => ADD_RD2(1), A2 => n442, ZN => n411);
   U410 : NAND2_X1 port map( A1 => ADD_RD2(0), A2 => ADD_RD2(1), ZN => n410);
   U411 : INV_X1 port map( A => ADD_RD2(0), ZN => n442);
   U412 : OAI222_X1 port map( A1 => n443, A2 => n444, B1 => n445, B2 => n446, 
                           C1 => n187, C2 => n447, ZN => n251);
   U413 : AOI221_X1 port map( B1 => n448, B2 => n362, C1 => n449, C2 => n340, A
                           => n450, ZN => n445);
   U414 : OAI22_X1 port map( A1 => n339, A2 => n451, B1 => n338, B2 => n452, ZN
                           => n450);
   U415 : OAI22_X1 port map( A1 => n203, A2 => n451, B1 => n211, B2 => n452, ZN
                           => n453);
   U416 : OAI222_X1 port map( A1 => n454, A2 => n444, B1 => n455, B2 => n446, 
                           C1 => n186, C2 => n447, ZN => n250);
   U417 : OAI22_X1 port map( A1 => n337, A2 => n451, B1 => n336, B2 => n452, ZN
                           => n456);
   U418 : OAI22_X1 port map( A1 => n202, A2 => n451, B1 => n210, B2 => n452, ZN
                           => n457);
   U419 : OAI222_X1 port map( A1 => n458, A2 => n444, B1 => n459, B2 => n446, 
                           C1 => n185, C2 => n447, ZN => n249);
   U420 : OAI22_X1 port map( A1 => n335, A2 => n451, B1 => n334, B2 => n452, ZN
                           => n460);
   U421 : OAI22_X1 port map( A1 => n201, A2 => n451, B1 => n209, B2 => n452, ZN
                           => n461);
   U422 : OAI222_X1 port map( A1 => n462, A2 => n444, B1 => n463, B2 => n446, 
                           C1 => n184, C2 => n447, ZN => n248);
   U423 : OAI22_X1 port map( A1 => n333, A2 => n451, B1 => n332, B2 => n452, ZN
                           => n464);
   U424 : AOI221_X1 port map( B1 => n448, B2 => n363, C1 => n449, C2 => n341, A
                           => n465, ZN => n462);
   U425 : OAI22_X1 port map( A1 => n200, A2 => n451, B1 => n208, B2 => n452, ZN
                           => n465);
   U426 : OAI222_X1 port map( A1 => n466, A2 => n444, B1 => n467, B2 => n446, 
                           C1 => n183, C2 => n447, ZN => n247);
   U427 : AOI221_X1 port map( B1 => n448, B2 => n364, C1 => n449, C2 => n342, A
                           => n468, ZN => n467);
   U428 : OAI22_X1 port map( A1 => n331, A2 => n451, B1 => n330, B2 => n452, ZN
                           => n468);
   U429 : AOI221_X1 port map( B1 => n448, B2 => n365, C1 => n449, C2 => n343, A
                           => n469, ZN => n466);
   U430 : OAI22_X1 port map( A1 => n199, A2 => n451, B1 => n207, B2 => n452, ZN
                           => n469);
   U431 : OAI222_X1 port map( A1 => n470, A2 => n444, B1 => n471, B2 => n446, 
                           C1 => n182, C2 => n447, ZN => n246);
   U432 : AOI221_X1 port map( B1 => n448, B2 => n366, C1 => n449, C2 => n344, A
                           => n472, ZN => n471);
   U433 : OAI22_X1 port map( A1 => n329, A2 => n451, B1 => n328, B2 => n452, ZN
                           => n472);
   U434 : AOI221_X1 port map( B1 => n448, B2 => n367, C1 => n449, C2 => n345, A
                           => n473, ZN => n470);
   U435 : OAI22_X1 port map( A1 => n198, A2 => n451, B1 => n206, B2 => n452, ZN
                           => n473);
   U436 : OAI222_X1 port map( A1 => n474, A2 => n444, B1 => n475, B2 => n446, 
                           C1 => n181, C2 => n447, ZN => n245);
   U437 : AOI221_X1 port map( B1 => n448, B2 => n368, C1 => n449, C2 => n346, A
                           => n476, ZN => n475);
   U438 : OAI22_X1 port map( A1 => n327, A2 => n451, B1 => n326, B2 => n452, ZN
                           => n476);
   U439 : AOI221_X1 port map( B1 => n448, B2 => n369, C1 => n449, C2 => n347, A
                           => n477, ZN => n474);
   U440 : OAI22_X1 port map( A1 => n197, A2 => n451, B1 => n205, B2 => n452, ZN
                           => n477);
   U441 : OAI222_X1 port map( A1 => n478, A2 => n444, B1 => n479, B2 => n446, 
                           C1 => n180, C2 => n447, ZN => n244);
   U442 : NAND2_X1 port map( A1 => n447, A2 => n480, ZN => n446);
   U443 : INV_X1 port map( A => ADD_RD1(2), ZN => n480);
   U444 : AOI221_X1 port map( B1 => n448, B2 => n370, C1 => n449, C2 => n348, A
                           => n481, ZN => n479);
   U445 : OAI22_X1 port map( A1 => n325, A2 => n451, B1 => n324, B2 => n452, ZN
                           => n481);
   U446 : NAND2_X1 port map( A1 => ADD_RD1(2), A2 => n447, ZN => n444);
   U447 : AND2_X1 port map( A1 => RD1, A2 => ENABLE, ZN => n447);
   U448 : AOI221_X1 port map( B1 => n448, B2 => n371, C1 => n449, C2 => n349, A
                           => n482, ZN => n478);
   U449 : OAI22_X1 port map( A1 => n196, A2 => n451, B1 => n204, B2 => n452, ZN
                           => n482);
   U450 : NAND2_X1 port map( A1 => ADD_RD1(1), A2 => n483, ZN => n452);
   U451 : NAND2_X1 port map( A1 => ADD_RD1(0), A2 => ADD_RD1(1), ZN => n451);
   U452 : INV_X1 port map( A => ADD_RD1(0), ZN => n483);

end SYN_A;
