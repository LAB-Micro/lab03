
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
   
   component AND3_X1
      port( A1, A2, A3 : in std_logic;  ZN : out std_logic);
   end component;
   
   component AND2_X1
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component OAI22_X1
      port( A1, A2, B1, B2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component NAND2_X1
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component AOI221_X1
      port( B1, B2, C1, C2, A : in std_logic;  ZN : out std_logic);
   end component;
   
   component OAI222_X1
      port( A1, A2, B1, B2, C1, C2 : in std_logic;  ZN : out std_logic);
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
   
   signal n180, n181, n182, n183, n184, n185, n186, n187, n188, n189, n190, 
      n191, n192, n193, n194, n195, n244, n245, n246, n247, n248, n249, n250, 
      n251, n252, n253, n254, n255, n256, n257, n258, n259, n260, n261, n262, 
      n263, n264, n265, n266, n267, n268, n269, n270, n271, n272, n273, n274, 
      n275, n276, n277, n278, n279, n280, n281, n282, n283, n284, n285, n286, 
      n287, n288, n289, n290, n291, n292, n293, n294, n295, n296, n297, n298, 
      n299, n300, n301, n302, n303, n304, n305, n306, n307, n308, n309, n310, 
      n311, n312, n313, n314, n315, n316, n317, n318, n319, n320, n321, n322, 
      n323, n340, n341, n342, n343, n344, n345, n346, n347, n348, n349, n350, 
      n351, n352, n353, n354, n355, n356, n357, n358, n359, n360, n361, n362, 
      n363, n364, n365, n366, n367, n368, n369, n370, n371, n564, n565, n566, 
      n567, n568, n569, n570, n571, n572, n573, n574, n575, n576, n577, n578, 
      n579, n580, n581, n582, n583, n584, n585, n586, n587, n588, n589, n590, 
      n591, n592, n593, n594, n595, n596, n597, n598, n599, n600, n601, n602, 
      n603, n604, n605, n606, n607, n608, n609, n610, n611, n612, n613, n614, 
      n615, n616, n617, n618, n619, n620, n621, n622, n623, n624, n625, n626, 
      n627, n628, n629, n630, n631, n632, n633, n634, n635, n636, n637, n638, 
      n639, n640, n641, n642, n643, n644, n645, n646, n647, n648, n649, n650, 
      n651, n652, n653, n654, n655, n656, n657, n658, n659, n660, n661, n662, 
      n663, n664, n665, n666, n667, n668, n669, n670, n671, n672, n673, n674, 
      n675, n676, n677, n678, n679, n680, n681, n682, n683, n684, n685, n686, 
      n687, n688, n689, n690, n691, n692, n693, n694, n695, n696, n697, n698, 
      n699, n700, n701, n702, n703, n704, n705, n706, n707, n708, n709, n710, 
      n711, n712, n713, n714, n715, n716, n717, n718, n719, n720, n721, n722, 
      n723, n724, n725, n726, n727, n728, n729, n730, n731, n732, n733, n734, 
      n735, n736, n737, n738, n739, n772, n773, n774, n775, n776, n777, n778, 
      n779, n780, n781, n782, n783, n784, n785, n786, n787, n788, n789, n790, 
      n791, n792, n793, n794, n795, n796, n797, n798, n799, n800, n801, n802, 
      n803 : std_logic;

begin
   
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
   REGISTERS_reg_7_7_inst : DFF_X1 port map( D => n267, CK => CLK, Q => n803, 
                           QN => n650);
   REGISTERS_reg_7_6_inst : DFF_X1 port map( D => n266, CK => CLK, Q => n802, 
                           QN => n651);
   REGISTERS_reg_7_5_inst : DFF_X1 port map( D => n265, CK => CLK, Q => n801, 
                           QN => n652);
   REGISTERS_reg_7_4_inst : DFF_X1 port map( D => n264, CK => CLK, Q => n800, 
                           QN => n653);
   REGISTERS_reg_7_3_inst : DFF_X1 port map( D => n263, CK => CLK, Q => n799, 
                           QN => n654);
   REGISTERS_reg_7_2_inst : DFF_X1 port map( D => n262, CK => CLK, Q => n798, 
                           QN => n655);
   REGISTERS_reg_7_1_inst : DFF_X1 port map( D => n261, CK => CLK, Q => n797, 
                           QN => n656);
   REGISTERS_reg_7_0_inst : DFF_X1 port map( D => n260, CK => CLK, Q => n796, 
                           QN => n657);
   REGISTERS_reg_6_7_inst : DFF_X1 port map( D => n275, CK => CLK, Q => n795, 
                           QN => n640);
   REGISTERS_reg_6_6_inst : DFF_X1 port map( D => n274, CK => CLK, Q => n794, 
                           QN => n641);
   REGISTERS_reg_6_5_inst : DFF_X1 port map( D => n273, CK => CLK, Q => n793, 
                           QN => n642);
   REGISTERS_reg_6_4_inst : DFF_X1 port map( D => n272, CK => CLK, Q => n792, 
                           QN => n643);
   REGISTERS_reg_6_3_inst : DFF_X1 port map( D => n271, CK => CLK, Q => n791, 
                           QN => n644);
   REGISTERS_reg_6_2_inst : DFF_X1 port map( D => n270, CK => CLK, Q => n790, 
                           QN => n645);
   REGISTERS_reg_6_1_inst : DFF_X1 port map( D => n269, CK => CLK, Q => n789, 
                           QN => n646);
   REGISTERS_reg_6_0_inst : DFF_X1 port map( D => n268, CK => CLK, Q => n788, 
                           QN => n647);
   REGISTERS_reg_5_7_inst : DFF_X1 port map( D => n283, CK => CLK, Q => n356, 
                           QN => n630);
   REGISTERS_reg_5_6_inst : DFF_X1 port map( D => n282, CK => CLK, Q => n358, 
                           QN => n631);
   REGISTERS_reg_5_5_inst : DFF_X1 port map( D => n281, CK => CLK, Q => n360, 
                           QN => n632);
   REGISTERS_reg_5_4_inst : DFF_X1 port map( D => n280, CK => CLK, Q => n363, 
                           QN => n633);
   REGISTERS_reg_5_3_inst : DFF_X1 port map( D => n279, CK => CLK, Q => n365, 
                           QN => n634);
   REGISTERS_reg_5_2_inst : DFF_X1 port map( D => n278, CK => CLK, Q => n367, 
                           QN => n635);
   REGISTERS_reg_5_1_inst : DFF_X1 port map( D => n277, CK => CLK, Q => n369, 
                           QN => n636);
   REGISTERS_reg_5_0_inst : DFF_X1 port map( D => n276, CK => CLK, Q => n371, 
                           QN => n637);
   REGISTERS_reg_4_7_inst : DFF_X1 port map( D => n291, CK => CLK, Q => n350, 
                           QN => n619);
   REGISTERS_reg_4_6_inst : DFF_X1 port map( D => n290, CK => CLK, Q => n352, 
                           QN => n620);
   REGISTERS_reg_4_5_inst : DFF_X1 port map( D => n289, CK => CLK, Q => n354, 
                           QN => n621);
   REGISTERS_reg_4_4_inst : DFF_X1 port map( D => n288, CK => CLK, Q => n341, 
                           QN => n622);
   REGISTERS_reg_4_3_inst : DFF_X1 port map( D => n287, CK => CLK, Q => n343, 
                           QN => n623);
   REGISTERS_reg_4_2_inst : DFF_X1 port map( D => n286, CK => CLK, Q => n345, 
                           QN => n624);
   REGISTERS_reg_4_1_inst : DFF_X1 port map( D => n285, CK => CLK, Q => n347, 
                           QN => n625);
   REGISTERS_reg_4_0_inst : DFF_X1 port map( D => n284, CK => CLK, Q => n349, 
                           QN => n626);
   REGISTERS_reg_2_7_inst : DFF_X1 port map( D => n307, CK => CLK, Q => n787, 
                           QN => n598);
   REGISTERS_reg_2_6_inst : DFF_X1 port map( D => n306, CK => CLK, Q => n786, 
                           QN => n599);
   REGISTERS_reg_2_5_inst : DFF_X1 port map( D => n305, CK => CLK, Q => n785, 
                           QN => n600);
   REGISTERS_reg_2_4_inst : DFF_X1 port map( D => n304, CK => CLK, Q => n784, 
                           QN => n601);
   REGISTERS_reg_2_3_inst : DFF_X1 port map( D => n303, CK => CLK, Q => n783, 
                           QN => n602);
   REGISTERS_reg_2_2_inst : DFF_X1 port map( D => n302, CK => CLK, Q => n782, 
                           QN => n603);
   REGISTERS_reg_2_1_inst : DFF_X1 port map( D => n301, CK => CLK, Q => n781, 
                           QN => n604);
   REGISTERS_reg_2_0_inst : DFF_X1 port map( D => n300, CK => CLK, Q => n780, 
                           QN => n605);
   REGISTERS_reg_1_7_inst : DFF_X1 port map( D => n315, CK => CLK, Q => n362, 
                           QN => n588);
   REGISTERS_reg_1_6_inst : DFF_X1 port map( D => n314, CK => CLK, Q => n357, 
                           QN => n589);
   REGISTERS_reg_1_5_inst : DFF_X1 port map( D => n313, CK => CLK, Q => n359, 
                           QN => n590);
   REGISTERS_reg_1_4_inst : DFF_X1 port map( D => n312, CK => CLK, Q => n361, 
                           QN => n591);
   REGISTERS_reg_1_3_inst : DFF_X1 port map( D => n311, CK => CLK, Q => n364, 
                           QN => n592);
   REGISTERS_reg_1_2_inst : DFF_X1 port map( D => n310, CK => CLK, Q => n366, 
                           QN => n593);
   REGISTERS_reg_1_1_inst : DFF_X1 port map( D => n309, CK => CLK, Q => n368, 
                           QN => n594);
   REGISTERS_reg_1_0_inst : DFF_X1 port map( D => n308, CK => CLK, Q => n370, 
                           QN => n595);
   REGISTERS_reg_3_7_inst : DFF_X1 port map( D => n299, CK => CLK, Q => n779, 
                           QN => n608);
   REGISTERS_reg_3_6_inst : DFF_X1 port map( D => n298, CK => CLK, Q => n778, 
                           QN => n609);
   REGISTERS_reg_3_5_inst : DFF_X1 port map( D => n297, CK => CLK, Q => n777, 
                           QN => n610);
   REGISTERS_reg_3_4_inst : DFF_X1 port map( D => n296, CK => CLK, Q => n776, 
                           QN => n611);
   REGISTERS_reg_3_3_inst : DFF_X1 port map( D => n295, CK => CLK, Q => n775, 
                           QN => n612);
   REGISTERS_reg_3_2_inst : DFF_X1 port map( D => n294, CK => CLK, Q => n774, 
                           QN => n613);
   REGISTERS_reg_3_1_inst : DFF_X1 port map( D => n293, CK => CLK, Q => n773, 
                           QN => n614);
   REGISTERS_reg_3_0_inst : DFF_X1 port map( D => n292, CK => CLK, Q => n772, 
                           QN => n615);
   REGISTERS_reg_0_7_inst : DFF_X1 port map( D => n323, CK => CLK, Q => n340, 
                           QN => n567);
   REGISTERS_reg_0_6_inst : DFF_X1 port map( D => n322, CK => CLK, Q => n351, 
                           QN => n569);
   REGISTERS_reg_0_5_inst : DFF_X1 port map( D => n321, CK => CLK, Q => n353, 
                           QN => n571);
   REGISTERS_reg_0_4_inst : DFF_X1 port map( D => n320, CK => CLK, Q => n355, 
                           QN => n573);
   REGISTERS_reg_0_3_inst : DFF_X1 port map( D => n319, CK => CLK, Q => n342, 
                           QN => n575);
   REGISTERS_reg_0_2_inst : DFF_X1 port map( D => n318, CK => CLK, Q => n344, 
                           QN => n577);
   REGISTERS_reg_0_1_inst : DFF_X1 port map( D => n317, CK => CLK, Q => n346, 
                           QN => n579);
   REGISTERS_reg_0_0_inst : DFF_X1 port map( D => n316, CK => CLK, Q => n348, 
                           QN => n581);
   U517 : NAND2_X1 port map( A1 => ADD_RD1(1), A2 => n739, ZN => n708);
   U518 : NAND2_X1 port map( A1 => ADD_RD2(1), A2 => n698, ZN => n667);
   U519 : NAND2_X1 port map( A1 => ADD_RD1(0), A2 => ADD_RD1(1), ZN => n707);
   U520 : NAND2_X1 port map( A1 => ADD_RD2(0), A2 => ADD_RD2(1), ZN => n666);
   U521 : NAND3_X1 port map( A1 => n583, A2 => n584, A3 => n627, ZN => n617);
   U522 : NAND3_X1 port map( A1 => n583, A2 => n584, A3 => n585, ZN => n564);
   U523 : NAND2_X1 port map( A1 => n582, A2 => n648, ZN => n649);
   U524 : NAND2_X1 port map( A1 => n582, A2 => n638, ZN => n639);
   U525 : NAND2_X1 port map( A1 => n582, A2 => n628, ZN => n629);
   U526 : NAND2_X1 port map( A1 => n582, A2 => n617, ZN => n618);
   U527 : NAND2_X1 port map( A1 => n582, A2 => n596, ZN => n597);
   U528 : NAND2_X1 port map( A1 => n582, A2 => n586, ZN => n587);
   U529 : NAND2_X1 port map( A1 => n582, A2 => n606, ZN => n607);
   U530 : NAND2_X1 port map( A1 => n582, A2 => n564, ZN => n566);
   U531 : OAI22_X1 port map( A1 => n615, A2 => n707, B1 => n605, B2 => n708, ZN
                           => n737);
   U532 : OAI22_X1 port map( A1 => n614, A2 => n707, B1 => n604, B2 => n708, ZN
                           => n732);
   U533 : OAI22_X1 port map( A1 => n613, A2 => n707, B1 => n603, B2 => n708, ZN
                           => n728);
   U534 : OAI22_X1 port map( A1 => n612, A2 => n707, B1 => n602, B2 => n708, ZN
                           => n724);
   U535 : OAI22_X1 port map( A1 => n611, A2 => n707, B1 => n601, B2 => n708, ZN
                           => n720);
   U536 : OAI22_X1 port map( A1 => n610, A2 => n707, B1 => n600, B2 => n708, ZN
                           => n716);
   U537 : OAI22_X1 port map( A1 => n609, A2 => n707, B1 => n599, B2 => n708, ZN
                           => n712);
   U538 : OAI22_X1 port map( A1 => n608, A2 => n707, B1 => n598, B2 => n708, ZN
                           => n706);
   U539 : OAI22_X1 port map( A1 => n615, A2 => n666, B1 => n605, B2 => n667, ZN
                           => n696);
   U540 : OAI22_X1 port map( A1 => n614, A2 => n666, B1 => n604, B2 => n667, ZN
                           => n691);
   U541 : OAI22_X1 port map( A1 => n613, A2 => n666, B1 => n603, B2 => n667, ZN
                           => n687);
   U542 : OAI22_X1 port map( A1 => n612, A2 => n666, B1 => n602, B2 => n667, ZN
                           => n683);
   U543 : OAI22_X1 port map( A1 => n611, A2 => n666, B1 => n601, B2 => n667, ZN
                           => n679);
   U544 : OAI22_X1 port map( A1 => n610, A2 => n666, B1 => n600, B2 => n667, ZN
                           => n675);
   U545 : OAI22_X1 port map( A1 => n609, A2 => n666, B1 => n599, B2 => n667, ZN
                           => n671);
   U546 : OAI22_X1 port map( A1 => n608, A2 => n666, B1 => n598, B2 => n667, ZN
                           => n665);
   U547 : OAI22_X1 port map( A1 => n580, A2 => n648, B1 => n649, B2 => n657, ZN
                           => n260);
   U548 : OAI22_X1 port map( A1 => n578, A2 => n648, B1 => n649, B2 => n656, ZN
                           => n261);
   U549 : OAI22_X1 port map( A1 => n576, A2 => n648, B1 => n649, B2 => n655, ZN
                           => n262);
   U550 : OAI22_X1 port map( A1 => n574, A2 => n648, B1 => n649, B2 => n654, ZN
                           => n263);
   U551 : OAI22_X1 port map( A1 => n572, A2 => n648, B1 => n649, B2 => n653, ZN
                           => n264);
   U552 : OAI22_X1 port map( A1 => n570, A2 => n648, B1 => n649, B2 => n652, ZN
                           => n265);
   U553 : OAI22_X1 port map( A1 => n568, A2 => n648, B1 => n649, B2 => n651, ZN
                           => n266);
   U554 : OAI22_X1 port map( A1 => n565, A2 => n648, B1 => n649, B2 => n650, ZN
                           => n267);
   U555 : OAI22_X1 port map( A1 => n580, A2 => n638, B1 => n639, B2 => n647, ZN
                           => n268);
   U556 : OAI22_X1 port map( A1 => n578, A2 => n638, B1 => n639, B2 => n646, ZN
                           => n269);
   U557 : OAI22_X1 port map( A1 => n576, A2 => n638, B1 => n639, B2 => n645, ZN
                           => n270);
   U558 : OAI22_X1 port map( A1 => n574, A2 => n638, B1 => n639, B2 => n644, ZN
                           => n271);
   U559 : OAI22_X1 port map( A1 => n572, A2 => n638, B1 => n639, B2 => n643, ZN
                           => n272);
   U560 : OAI22_X1 port map( A1 => n570, A2 => n638, B1 => n639, B2 => n642, ZN
                           => n273);
   U561 : OAI22_X1 port map( A1 => n568, A2 => n638, B1 => n639, B2 => n641, ZN
                           => n274);
   U562 : OAI22_X1 port map( A1 => n565, A2 => n638, B1 => n639, B2 => n640, ZN
                           => n275);
   U563 : OAI22_X1 port map( A1 => n580, A2 => n606, B1 => n607, B2 => n615, ZN
                           => n292);
   U564 : OAI22_X1 port map( A1 => n578, A2 => n606, B1 => n607, B2 => n614, ZN
                           => n293);
   U565 : OAI22_X1 port map( A1 => n576, A2 => n606, B1 => n607, B2 => n613, ZN
                           => n294);
   U566 : OAI22_X1 port map( A1 => n574, A2 => n606, B1 => n607, B2 => n612, ZN
                           => n295);
   U567 : OAI22_X1 port map( A1 => n572, A2 => n606, B1 => n607, B2 => n611, ZN
                           => n296);
   U568 : OAI22_X1 port map( A1 => n570, A2 => n606, B1 => n607, B2 => n610, ZN
                           => n297);
   U569 : OAI22_X1 port map( A1 => n568, A2 => n606, B1 => n607, B2 => n609, ZN
                           => n298);
   U570 : OAI22_X1 port map( A1 => n565, A2 => n606, B1 => n607, B2 => n608, ZN
                           => n299);
   U571 : OAI22_X1 port map( A1 => n580, A2 => n596, B1 => n597, B2 => n605, ZN
                           => n300);
   U572 : OAI22_X1 port map( A1 => n578, A2 => n596, B1 => n597, B2 => n604, ZN
                           => n301);
   U573 : OAI22_X1 port map( A1 => n576, A2 => n596, B1 => n597, B2 => n603, ZN
                           => n302);
   U574 : OAI22_X1 port map( A1 => n574, A2 => n596, B1 => n597, B2 => n602, ZN
                           => n303);
   U575 : OAI22_X1 port map( A1 => n572, A2 => n596, B1 => n597, B2 => n601, ZN
                           => n304);
   U576 : OAI22_X1 port map( A1 => n570, A2 => n596, B1 => n597, B2 => n600, ZN
                           => n305);
   U577 : OAI22_X1 port map( A1 => n568, A2 => n596, B1 => n597, B2 => n599, ZN
                           => n306);
   U578 : OAI22_X1 port map( A1 => n565, A2 => n596, B1 => n597, B2 => n598, ZN
                           => n307);
   U579 : NOR2_X2 port map( A1 => ADD_RD1(0), A2 => ADD_RD1(1), ZN => n704);
   U580 : NOR2_X2 port map( A1 => ADD_RD2(0), A2 => ADD_RD2(1), ZN => n663);
   U581 : NOR2_X2 port map( A1 => n739, A2 => ADD_RD1(1), ZN => n705);
   U582 : NOR2_X2 port map( A1 => n698, A2 => ADD_RD2(1), ZN => n664);
   U583 : NAND3_X1 port map( A1 => ADD_WR(1), A2 => ADD_WR(0), A3 => n627, ZN 
                           => n648);
   U584 : NAND3_X1 port map( A1 => ADD_WR(1), A2 => n583, A3 => n627, ZN => 
                           n638);
   U585 : NAND3_X1 port map( A1 => ADD_WR(0), A2 => n584, A3 => n627, ZN => 
                           n628);
   U586 : NAND3_X1 port map( A1 => n585, A2 => n583, A3 => ADD_WR(1), ZN => 
                           n596);
   U587 : NAND3_X1 port map( A1 => n585, A2 => n584, A3 => ADD_WR(0), ZN => 
                           n586);
   U588 : NAND3_X1 port map( A1 => ADD_WR(0), A2 => n585, A3 => ADD_WR(1), ZN 
                           => n606);
   U589 : OAI222_X1 port map( A1 => n734, A2 => n700, B1 => n735, B2 => n702, 
                           C1 => n180, C2 => n703, ZN => n244);
   U590 : AOI221_X1 port map( B1 => n704, B2 => n349, C1 => n705, C2 => n371, A
                           => n738, ZN => n734);
   U591 : AOI221_X1 port map( B1 => n704, B2 => n348, C1 => n705, C2 => n370, A
                           => n737, ZN => n735);
   U592 : OAI22_X1 port map( A1 => n657, A2 => n707, B1 => n647, B2 => n708, ZN
                           => n738);
   U593 : OAI222_X1 port map( A1 => n730, A2 => n700, B1 => n731, B2 => n702, 
                           C1 => n181, C2 => n703, ZN => n245);
   U594 : AOI221_X1 port map( B1 => n704, B2 => n347, C1 => n705, C2 => n369, A
                           => n733, ZN => n730);
   U595 : AOI221_X1 port map( B1 => n704, B2 => n346, C1 => n705, C2 => n368, A
                           => n732, ZN => n731);
   U596 : OAI22_X1 port map( A1 => n656, A2 => n707, B1 => n646, B2 => n708, ZN
                           => n733);
   U597 : OAI222_X1 port map( A1 => n726, A2 => n700, B1 => n727, B2 => n702, 
                           C1 => n182, C2 => n703, ZN => n246);
   U598 : AOI221_X1 port map( B1 => n704, B2 => n345, C1 => n705, C2 => n367, A
                           => n729, ZN => n726);
   U599 : AOI221_X1 port map( B1 => n704, B2 => n344, C1 => n705, C2 => n366, A
                           => n728, ZN => n727);
   U600 : OAI22_X1 port map( A1 => n655, A2 => n707, B1 => n645, B2 => n708, ZN
                           => n729);
   U601 : OAI222_X1 port map( A1 => n722, A2 => n700, B1 => n723, B2 => n702, 
                           C1 => n183, C2 => n703, ZN => n247);
   U602 : AOI221_X1 port map( B1 => n704, B2 => n343, C1 => n705, C2 => n365, A
                           => n725, ZN => n722);
   U603 : AOI221_X1 port map( B1 => n704, B2 => n342, C1 => n705, C2 => n364, A
                           => n724, ZN => n723);
   U604 : OAI22_X1 port map( A1 => n654, A2 => n707, B1 => n644, B2 => n708, ZN
                           => n725);
   U605 : OAI222_X1 port map( A1 => n718, A2 => n700, B1 => n719, B2 => n702, 
                           C1 => n184, C2 => n703, ZN => n248);
   U606 : AOI221_X1 port map( B1 => n704, B2 => n341, C1 => n705, C2 => n363, A
                           => n721, ZN => n718);
   U607 : AOI221_X1 port map( B1 => n704, B2 => n355, C1 => n705, C2 => n361, A
                           => n720, ZN => n719);
   U608 : OAI22_X1 port map( A1 => n653, A2 => n707, B1 => n643, B2 => n708, ZN
                           => n721);
   U609 : OAI222_X1 port map( A1 => n714, A2 => n700, B1 => n715, B2 => n702, 
                           C1 => n185, C2 => n703, ZN => n249);
   U610 : AOI221_X1 port map( B1 => n704, B2 => n354, C1 => n705, C2 => n360, A
                           => n717, ZN => n714);
   U611 : AOI221_X1 port map( B1 => n704, B2 => n353, C1 => n705, C2 => n359, A
                           => n716, ZN => n715);
   U612 : OAI22_X1 port map( A1 => n652, A2 => n707, B1 => n642, B2 => n708, ZN
                           => n717);
   U613 : OAI222_X1 port map( A1 => n710, A2 => n700, B1 => n711, B2 => n702, 
                           C1 => n186, C2 => n703, ZN => n250);
   U614 : AOI221_X1 port map( B1 => n704, B2 => n352, C1 => n705, C2 => n358, A
                           => n713, ZN => n710);
   U615 : AOI221_X1 port map( B1 => n704, B2 => n351, C1 => n705, C2 => n357, A
                           => n712, ZN => n711);
   U616 : OAI22_X1 port map( A1 => n651, A2 => n707, B1 => n641, B2 => n708, ZN
                           => n713);
   U617 : OAI222_X1 port map( A1 => n699, A2 => n700, B1 => n701, B2 => n702, 
                           C1 => n187, C2 => n703, ZN => n251);
   U618 : AOI221_X1 port map( B1 => n704, B2 => n350, C1 => n705, C2 => n356, A
                           => n709, ZN => n699);
   U619 : AOI221_X1 port map( B1 => n704, B2 => n340, C1 => n705, C2 => n362, A
                           => n706, ZN => n701);
   U620 : OAI22_X1 port map( A1 => n650, A2 => n707, B1 => n640, B2 => n708, ZN
                           => n709);
   U621 : OAI222_X1 port map( A1 => n693, A2 => n659, B1 => n694, B2 => n661, 
                           C1 => n188, C2 => n662, ZN => n252);
   U622 : AOI221_X1 port map( B1 => n663, B2 => n349, C1 => n664, C2 => n371, A
                           => n697, ZN => n693);
   U623 : AOI221_X1 port map( B1 => n663, B2 => n348, C1 => n664, C2 => n370, A
                           => n696, ZN => n694);
   U624 : OAI22_X1 port map( A1 => n657, A2 => n666, B1 => n647, B2 => n667, ZN
                           => n697);
   U625 : OAI222_X1 port map( A1 => n689, A2 => n659, B1 => n690, B2 => n661, 
                           C1 => n189, C2 => n662, ZN => n253);
   U626 : AOI221_X1 port map( B1 => n663, B2 => n347, C1 => n664, C2 => n369, A
                           => n692, ZN => n689);
   U627 : AOI221_X1 port map( B1 => n663, B2 => n346, C1 => n664, C2 => n368, A
                           => n691, ZN => n690);
   U628 : OAI22_X1 port map( A1 => n656, A2 => n666, B1 => n646, B2 => n667, ZN
                           => n692);
   U629 : OAI222_X1 port map( A1 => n685, A2 => n659, B1 => n686, B2 => n661, 
                           C1 => n190, C2 => n662, ZN => n254);
   U630 : AOI221_X1 port map( B1 => n663, B2 => n345, C1 => n664, C2 => n367, A
                           => n688, ZN => n685);
   U631 : AOI221_X1 port map( B1 => n663, B2 => n344, C1 => n664, C2 => n366, A
                           => n687, ZN => n686);
   U632 : OAI22_X1 port map( A1 => n655, A2 => n666, B1 => n645, B2 => n667, ZN
                           => n688);
   U633 : OAI222_X1 port map( A1 => n681, A2 => n659, B1 => n682, B2 => n661, 
                           C1 => n191, C2 => n662, ZN => n255);
   U634 : AOI221_X1 port map( B1 => n663, B2 => n343, C1 => n664, C2 => n365, A
                           => n684, ZN => n681);
   U635 : AOI221_X1 port map( B1 => n663, B2 => n342, C1 => n664, C2 => n364, A
                           => n683, ZN => n682);
   U636 : OAI22_X1 port map( A1 => n654, A2 => n666, B1 => n644, B2 => n667, ZN
                           => n684);
   U637 : OAI222_X1 port map( A1 => n677, A2 => n659, B1 => n678, B2 => n661, 
                           C1 => n192, C2 => n662, ZN => n256);
   U638 : AOI221_X1 port map( B1 => n663, B2 => n341, C1 => n664, C2 => n363, A
                           => n680, ZN => n677);
   U639 : AOI221_X1 port map( B1 => n663, B2 => n355, C1 => n664, C2 => n361, A
                           => n679, ZN => n678);
   U640 : OAI22_X1 port map( A1 => n653, A2 => n666, B1 => n643, B2 => n667, ZN
                           => n680);
   U641 : OAI222_X1 port map( A1 => n673, A2 => n659, B1 => n674, B2 => n661, 
                           C1 => n193, C2 => n662, ZN => n257);
   U642 : AOI221_X1 port map( B1 => n663, B2 => n354, C1 => n664, C2 => n360, A
                           => n676, ZN => n673);
   U643 : AOI221_X1 port map( B1 => n663, B2 => n353, C1 => n664, C2 => n359, A
                           => n675, ZN => n674);
   U644 : OAI22_X1 port map( A1 => n652, A2 => n666, B1 => n642, B2 => n667, ZN
                           => n676);
   U645 : OAI222_X1 port map( A1 => n669, A2 => n659, B1 => n670, B2 => n661, 
                           C1 => n194, C2 => n662, ZN => n258);
   U646 : AOI221_X1 port map( B1 => n663, B2 => n352, C1 => n664, C2 => n358, A
                           => n672, ZN => n669);
   U647 : AOI221_X1 port map( B1 => n663, B2 => n351, C1 => n664, C2 => n357, A
                           => n671, ZN => n670);
   U648 : OAI22_X1 port map( A1 => n651, A2 => n666, B1 => n641, B2 => n667, ZN
                           => n672);
   U649 : OAI222_X1 port map( A1 => n658, A2 => n659, B1 => n660, B2 => n661, 
                           C1 => n195, C2 => n662, ZN => n259);
   U650 : AOI221_X1 port map( B1 => n663, B2 => n350, C1 => n664, C2 => n356, A
                           => n668, ZN => n658);
   U651 : AOI221_X1 port map( B1 => n663, B2 => n340, C1 => n664, C2 => n362, A
                           => n665, ZN => n660);
   U652 : OAI22_X1 port map( A1 => n650, A2 => n666, B1 => n640, B2 => n667, ZN
                           => n668);
   U653 : NAND2_X1 port map( A1 => ADD_RD1(2), A2 => n703, ZN => n700);
   U654 : NAND2_X1 port map( A1 => ADD_RD2(2), A2 => n662, ZN => n659);
   U655 : NAND2_X1 port map( A1 => n703, A2 => n736, ZN => n702);
   U656 : INV_X1 port map( A => ADD_RD1(2), ZN => n736);
   U657 : NAND2_X1 port map( A1 => n662, A2 => n695, ZN => n661);
   U658 : INV_X1 port map( A => ADD_RD2(2), ZN => n695);
   U659 : INV_X1 port map( A => DATAIN(0), ZN => n580);
   U660 : INV_X1 port map( A => DATAIN(1), ZN => n578);
   U661 : INV_X1 port map( A => DATAIN(2), ZN => n576);
   U662 : INV_X1 port map( A => DATAIN(3), ZN => n574);
   U663 : INV_X1 port map( A => DATAIN(4), ZN => n572);
   U664 : INV_X1 port map( A => DATAIN(5), ZN => n570);
   U665 : INV_X1 port map( A => DATAIN(6), ZN => n568);
   U666 : INV_X1 port map( A => DATAIN(7), ZN => n565);
   U667 : INV_X1 port map( A => RESET, ZN => n582);
   U668 : OAI22_X1 port map( A1 => n564, A2 => n580, B1 => n566, B2 => n581, ZN
                           => n316);
   U669 : OAI22_X1 port map( A1 => n564, A2 => n578, B1 => n566, B2 => n579, ZN
                           => n317);
   U670 : OAI22_X1 port map( A1 => n564, A2 => n576, B1 => n566, B2 => n577, ZN
                           => n318);
   U671 : OAI22_X1 port map( A1 => n564, A2 => n574, B1 => n566, B2 => n575, ZN
                           => n319);
   U672 : OAI22_X1 port map( A1 => n564, A2 => n572, B1 => n566, B2 => n573, ZN
                           => n320);
   U673 : OAI22_X1 port map( A1 => n564, A2 => n570, B1 => n566, B2 => n571, ZN
                           => n321);
   U674 : OAI22_X1 port map( A1 => n564, A2 => n568, B1 => n566, B2 => n569, ZN
                           => n322);
   U675 : OAI22_X1 port map( A1 => n564, A2 => n565, B1 => n566, B2 => n567, ZN
                           => n323);
   U676 : OAI22_X1 port map( A1 => n580, A2 => n628, B1 => n629, B2 => n637, ZN
                           => n276);
   U677 : OAI22_X1 port map( A1 => n578, A2 => n628, B1 => n629, B2 => n636, ZN
                           => n277);
   U678 : OAI22_X1 port map( A1 => n576, A2 => n628, B1 => n629, B2 => n635, ZN
                           => n278);
   U679 : OAI22_X1 port map( A1 => n574, A2 => n628, B1 => n629, B2 => n634, ZN
                           => n279);
   U680 : OAI22_X1 port map( A1 => n572, A2 => n628, B1 => n629, B2 => n633, ZN
                           => n280);
   U681 : OAI22_X1 port map( A1 => n570, A2 => n628, B1 => n629, B2 => n632, ZN
                           => n281);
   U682 : OAI22_X1 port map( A1 => n568, A2 => n628, B1 => n629, B2 => n631, ZN
                           => n282);
   U683 : OAI22_X1 port map( A1 => n565, A2 => n628, B1 => n629, B2 => n630, ZN
                           => n283);
   U684 : OAI22_X1 port map( A1 => n580, A2 => n617, B1 => n618, B2 => n626, ZN
                           => n284);
   U685 : OAI22_X1 port map( A1 => n578, A2 => n617, B1 => n618, B2 => n625, ZN
                           => n285);
   U686 : OAI22_X1 port map( A1 => n576, A2 => n617, B1 => n618, B2 => n624, ZN
                           => n286);
   U687 : OAI22_X1 port map( A1 => n574, A2 => n617, B1 => n618, B2 => n623, ZN
                           => n287);
   U688 : OAI22_X1 port map( A1 => n572, A2 => n617, B1 => n618, B2 => n622, ZN
                           => n288);
   U689 : OAI22_X1 port map( A1 => n570, A2 => n617, B1 => n618, B2 => n621, ZN
                           => n289);
   U690 : OAI22_X1 port map( A1 => n568, A2 => n617, B1 => n618, B2 => n620, ZN
                           => n290);
   U691 : OAI22_X1 port map( A1 => n565, A2 => n617, B1 => n618, B2 => n619, ZN
                           => n291);
   U692 : OAI22_X1 port map( A1 => n580, A2 => n586, B1 => n587, B2 => n595, ZN
                           => n308);
   U693 : OAI22_X1 port map( A1 => n578, A2 => n586, B1 => n587, B2 => n594, ZN
                           => n309);
   U694 : OAI22_X1 port map( A1 => n576, A2 => n586, B1 => n587, B2 => n593, ZN
                           => n310);
   U695 : OAI22_X1 port map( A1 => n574, A2 => n586, B1 => n587, B2 => n592, ZN
                           => n311);
   U696 : OAI22_X1 port map( A1 => n572, A2 => n586, B1 => n587, B2 => n591, ZN
                           => n312);
   U697 : OAI22_X1 port map( A1 => n570, A2 => n586, B1 => n587, B2 => n590, ZN
                           => n313);
   U698 : OAI22_X1 port map( A1 => n568, A2 => n586, B1 => n587, B2 => n589, ZN
                           => n314);
   U699 : OAI22_X1 port map( A1 => n565, A2 => n586, B1 => n587, B2 => n588, ZN
                           => n315);
   U700 : AND2_X1 port map( A1 => RD1, A2 => ENABLE, ZN => n703);
   U701 : AND2_X1 port map( A1 => RD2, A2 => ENABLE, ZN => n662);
   U702 : AND3_X1 port map( A1 => WR, A2 => ENABLE, A3 => ADD_WR(2), ZN => n627
                           );
   U703 : AND3_X1 port map( A1 => ENABLE, A2 => n616, A3 => WR, ZN => n585);
   U704 : INV_X1 port map( A => ADD_WR(2), ZN => n616);
   U705 : INV_X1 port map( A => ADD_WR(1), ZN => n584);
   U706 : INV_X1 port map( A => ADD_WR(0), ZN => n583);
   U707 : INV_X1 port map( A => ADD_RD1(0), ZN => n739);
   U708 : INV_X1 port map( A => ADD_RD2(0), ZN => n698);

end SYN_A;
