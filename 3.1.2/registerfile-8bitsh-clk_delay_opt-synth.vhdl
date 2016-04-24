
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
      n323, n567, n569, n571, n573, n575, n577, n579, n581, n588, n589, n590, 
      n591, n592, n593, n594, n595, n619, n620, n621, n622, n623, n624, n625, 
      n626, n630, n631, n632, n633, n634, n635, n636, n637, n772, n773, n774, 
      n775, n776, n777, n778, n779, n780, n781, n782, n783, n784, n785, n786, 
      n787, n788, n789, n790, n791, n792, n793, n794, n795, n796, n797, n798, 
      n799, n800, n801, n802, n803, n884, n885, n886, n887, n888, n889, n890, 
      n891, n892, n893, n894, n895, n896, n897, n898, n899, n900, n901, n902, 
      n903, n904, n905, n906, n907, n908, n909, n910, n911, n912, n913, n914, 
      n915, n916, n917, n918, n919, n920, n921, n922, n923, n924, n925, n926, 
      n927, n928, n929, n930, n931, n932, n933, n934, n935, n936, n937, n938, 
      n939, n940, n941, n942, n943, n944, n945, n946, n947, n948, n949, n950, 
      n951, n952, n953, n954, n955, n956, n957, n958, n959, n960, n961, n962, 
      n963, n964, n965, n966, n967, n968, n969, n970, n971, n972, n973, n974, 
      n975, n976, n977, n978, n979, n980, n981, n982, n983, n984, n985, n986, 
      n987, n988, n989, n990, n991, n992, n993, n994, n995, n996, n997, n998, 
      n999, n1000, n1001, n1002, n1003, n1004, n1005, n1006, n1007, n1008, 
      n1009, n1010, n1011, n1012, n1013, n1014, n1015, n1016, n1017, n1018, 
      n1019, n1020, n1021, n1022, n1023, n1024, n1025, n1026, n1027, n1028, 
      n1029, n1030, n1031, n1032, n1033, n1034, n1035, n1036, n1037, n1038, 
      n1039, n1040, n1041, n1042, n1043, n1044, n1045, n1046, n1047, n1048, 
      n1049, n1050, n1051, n1052, n1053, n1054, n1055, n1056, n1057, n1058, 
      n1059 : std_logic;

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
                           QN => n938);
   REGISTERS_reg_7_6_inst : DFF_X1 port map( D => n266, CK => CLK, Q => n802, 
                           QN => n939);
   REGISTERS_reg_7_5_inst : DFF_X1 port map( D => n265, CK => CLK, Q => n801, 
                           QN => n940);
   REGISTERS_reg_7_4_inst : DFF_X1 port map( D => n264, CK => CLK, Q => n800, 
                           QN => n941);
   REGISTERS_reg_7_3_inst : DFF_X1 port map( D => n263, CK => CLK, Q => n799, 
                           QN => n942);
   REGISTERS_reg_7_2_inst : DFF_X1 port map( D => n262, CK => CLK, Q => n798, 
                           QN => n943);
   REGISTERS_reg_7_1_inst : DFF_X1 port map( D => n261, CK => CLK, Q => n797, 
                           QN => n944);
   REGISTERS_reg_7_0_inst : DFF_X1 port map( D => n260, CK => CLK, Q => n796, 
                           QN => n945);
   REGISTERS_reg_6_7_inst : DFF_X1 port map( D => n275, CK => CLK, Q => n795, 
                           QN => n928);
   REGISTERS_reg_6_6_inst : DFF_X1 port map( D => n274, CK => CLK, Q => n794, 
                           QN => n929);
   REGISTERS_reg_6_5_inst : DFF_X1 port map( D => n273, CK => CLK, Q => n793, 
                           QN => n930);
   REGISTERS_reg_6_4_inst : DFF_X1 port map( D => n272, CK => CLK, Q => n792, 
                           QN => n931);
   REGISTERS_reg_6_3_inst : DFF_X1 port map( D => n271, CK => CLK, Q => n791, 
                           QN => n932);
   REGISTERS_reg_6_2_inst : DFF_X1 port map( D => n270, CK => CLK, Q => n790, 
                           QN => n933);
   REGISTERS_reg_6_1_inst : DFF_X1 port map( D => n269, CK => CLK, Q => n789, 
                           QN => n934);
   REGISTERS_reg_6_0_inst : DFF_X1 port map( D => n268, CK => CLK, Q => n788, 
                           QN => n935);
   REGISTERS_reg_2_7_inst : DFF_X1 port map( D => n307, CK => CLK, Q => n787, 
                           QN => n902);
   REGISTERS_reg_2_6_inst : DFF_X1 port map( D => n306, CK => CLK, Q => n786, 
                           QN => n903);
   REGISTERS_reg_2_5_inst : DFF_X1 port map( D => n305, CK => CLK, Q => n785, 
                           QN => n904);
   REGISTERS_reg_2_4_inst : DFF_X1 port map( D => n304, CK => CLK, Q => n784, 
                           QN => n905);
   REGISTERS_reg_2_3_inst : DFF_X1 port map( D => n303, CK => CLK, Q => n783, 
                           QN => n906);
   REGISTERS_reg_2_2_inst : DFF_X1 port map( D => n302, CK => CLK, Q => n782, 
                           QN => n907);
   REGISTERS_reg_2_1_inst : DFF_X1 port map( D => n301, CK => CLK, Q => n781, 
                           QN => n908);
   REGISTERS_reg_2_0_inst : DFF_X1 port map( D => n300, CK => CLK, Q => n780, 
                           QN => n909);
   REGISTERS_reg_3_7_inst : DFF_X1 port map( D => n299, CK => CLK, Q => n779, 
                           QN => n912);
   REGISTERS_reg_3_6_inst : DFF_X1 port map( D => n298, CK => CLK, Q => n778, 
                           QN => n913);
   REGISTERS_reg_3_5_inst : DFF_X1 port map( D => n297, CK => CLK, Q => n777, 
                           QN => n914);
   REGISTERS_reg_3_4_inst : DFF_X1 port map( D => n296, CK => CLK, Q => n776, 
                           QN => n915);
   REGISTERS_reg_3_3_inst : DFF_X1 port map( D => n295, CK => CLK, Q => n775, 
                           QN => n916);
   REGISTERS_reg_3_2_inst : DFF_X1 port map( D => n294, CK => CLK, Q => n774, 
                           QN => n917);
   REGISTERS_reg_3_1_inst : DFF_X1 port map( D => n293, CK => CLK, Q => n773, 
                           QN => n918);
   REGISTERS_reg_3_0_inst : DFF_X1 port map( D => n292, CK => CLK, Q => n772, 
                           QN => n919);
   REGISTERS_reg_5_7_inst : DFF_X1 port map( D => n283, CK => CLK, Q => n958, 
                           QN => n630);
   REGISTERS_reg_5_6_inst : DFF_X1 port map( D => n282, CK => CLK, Q => n966, 
                           QN => n631);
   REGISTERS_reg_5_5_inst : DFF_X1 port map( D => n281, CK => CLK, Q => n974, 
                           QN => n632);
   REGISTERS_reg_5_4_inst : DFF_X1 port map( D => n280, CK => CLK, Q => n982, 
                           QN => n633);
   REGISTERS_reg_5_3_inst : DFF_X1 port map( D => n279, CK => CLK, Q => n990, 
                           QN => n634);
   REGISTERS_reg_5_2_inst : DFF_X1 port map( D => n278, CK => CLK, Q => n998, 
                           QN => n635);
   REGISTERS_reg_5_1_inst : DFF_X1 port map( D => n277, CK => CLK, Q => n1006, 
                           QN => n636);
   REGISTERS_reg_5_0_inst : DFF_X1 port map( D => n276, CK => CLK, Q => n1015, 
                           QN => n637);
   REGISTERS_reg_4_7_inst : DFF_X1 port map( D => n291, CK => CLK, Q => n959, 
                           QN => n619);
   REGISTERS_reg_4_6_inst : DFF_X1 port map( D => n290, CK => CLK, Q => n967, 
                           QN => n620);
   REGISTERS_reg_4_5_inst : DFF_X1 port map( D => n289, CK => CLK, Q => n975, 
                           QN => n621);
   REGISTERS_reg_4_4_inst : DFF_X1 port map( D => n288, CK => CLK, Q => n983, 
                           QN => n622);
   REGISTERS_reg_4_3_inst : DFF_X1 port map( D => n287, CK => CLK, Q => n991, 
                           QN => n623);
   REGISTERS_reg_4_2_inst : DFF_X1 port map( D => n286, CK => CLK, Q => n999, 
                           QN => n624);
   REGISTERS_reg_4_1_inst : DFF_X1 port map( D => n285, CK => CLK, Q => n1007, 
                           QN => n625);
   REGISTERS_reg_4_0_inst : DFF_X1 port map( D => n284, CK => CLK, Q => n1016, 
                           QN => n626);
   REGISTERS_reg_1_7_inst : DFF_X1 port map( D => n315, CK => CLK, Q => n952, 
                           QN => n588);
   REGISTERS_reg_1_6_inst : DFF_X1 port map( D => n314, CK => CLK, Q => n963, 
                           QN => n589);
   REGISTERS_reg_1_5_inst : DFF_X1 port map( D => n313, CK => CLK, Q => n971, 
                           QN => n590);
   REGISTERS_reg_1_4_inst : DFF_X1 port map( D => n312, CK => CLK, Q => n979, 
                           QN => n591);
   REGISTERS_reg_1_3_inst : DFF_X1 port map( D => n311, CK => CLK, Q => n987, 
                           QN => n592);
   REGISTERS_reg_1_2_inst : DFF_X1 port map( D => n310, CK => CLK, Q => n995, 
                           QN => n593);
   REGISTERS_reg_1_1_inst : DFF_X1 port map( D => n309, CK => CLK, Q => n1003, 
                           QN => n594);
   REGISTERS_reg_1_0_inst : DFF_X1 port map( D => n308, CK => CLK, Q => n1012, 
                           QN => n595);
   REGISTERS_reg_0_7_inst : DFF_X1 port map( D => n323, CK => CLK, Q => n954, 
                           QN => n567);
   REGISTERS_reg_0_6_inst : DFF_X1 port map( D => n322, CK => CLK, Q => n964, 
                           QN => n569);
   REGISTERS_reg_0_5_inst : DFF_X1 port map( D => n321, CK => CLK, Q => n972, 
                           QN => n571);
   REGISTERS_reg_0_4_inst : DFF_X1 port map( D => n320, CK => CLK, Q => n980, 
                           QN => n573);
   REGISTERS_reg_0_3_inst : DFF_X1 port map( D => n319, CK => CLK, Q => n988, 
                           QN => n575);
   REGISTERS_reg_0_2_inst : DFF_X1 port map( D => n318, CK => CLK, Q => n996, 
                           QN => n577);
   REGISTERS_reg_0_1_inst : DFF_X1 port map( D => n317, CK => CLK, Q => n1004, 
                           QN => n579);
   REGISTERS_reg_0_0_inst : DFF_X1 port map( D => n316, CK => CLK, Q => n1013, 
                           QN => n581);
   U773 : NAND2_X1 port map( A1 => ADD_RD1(1), A2 => n1059, ZN => n1028);
   U774 : NAND2_X1 port map( A1 => ADD_RD2(1), A2 => n1018, ZN => n957);
   U775 : NAND2_X1 port map( A1 => ADD_RD1(0), A2 => ADD_RD1(1), ZN => n1027);
   U776 : NAND2_X1 port map( A1 => ADD_RD2(0), A2 => ADD_RD2(1), ZN => n956);
   U777 : NAND3_X1 port map( A1 => n895, A2 => n896, A3 => n923, ZN => n921);
   U778 : NAND3_X1 port map( A1 => n895, A2 => n896, A3 => n897, ZN => n884);
   U779 : NAND2_X1 port map( A1 => n894, A2 => n921, ZN => n922);
   U780 : NAND2_X1 port map( A1 => n894, A2 => n924, ZN => n925);
   U781 : NAND2_X1 port map( A1 => n894, A2 => n898, ZN => n899);
   U782 : NAND2_X1 port map( A1 => n894, A2 => n884, ZN => n886);
   U783 : NAND2_X1 port map( A1 => n894, A2 => n926, ZN => n927);
   U784 : NAND2_X1 port map( A1 => n894, A2 => n936, ZN => n937);
   U785 : NAND2_X1 port map( A1 => n894, A2 => n900, ZN => n901);
   U786 : NAND2_X1 port map( A1 => n894, A2 => n910, ZN => n911);
   U787 : OAI22_X1 port map( A1 => n919, A2 => n1027, B1 => n909, B2 => n1028, 
                           ZN => n1057);
   U788 : OAI22_X1 port map( A1 => n918, A2 => n1027, B1 => n908, B2 => n1028, 
                           ZN => n1052);
   U789 : OAI22_X1 port map( A1 => n917, A2 => n1027, B1 => n907, B2 => n1028, 
                           ZN => n1048);
   U790 : OAI22_X1 port map( A1 => n916, A2 => n1027, B1 => n906, B2 => n1028, 
                           ZN => n1044);
   U791 : OAI22_X1 port map( A1 => n915, A2 => n1027, B1 => n905, B2 => n1028, 
                           ZN => n1040);
   U792 : OAI22_X1 port map( A1 => n914, A2 => n1027, B1 => n904, B2 => n1028, 
                           ZN => n1036);
   U793 : OAI22_X1 port map( A1 => n913, A2 => n1027, B1 => n903, B2 => n1028, 
                           ZN => n1032);
   U794 : OAI22_X1 port map( A1 => n912, A2 => n1027, B1 => n902, B2 => n1028, 
                           ZN => n1026);
   U795 : OAI22_X1 port map( A1 => n919, A2 => n956, B1 => n909, B2 => n957, ZN
                           => n1014);
   U796 : OAI22_X1 port map( A1 => n918, A2 => n956, B1 => n908, B2 => n957, ZN
                           => n1005);
   U797 : OAI22_X1 port map( A1 => n917, A2 => n956, B1 => n907, B2 => n957, ZN
                           => n997);
   U798 : OAI22_X1 port map( A1 => n916, A2 => n956, B1 => n906, B2 => n957, ZN
                           => n989);
   U799 : OAI22_X1 port map( A1 => n915, A2 => n956, B1 => n905, B2 => n957, ZN
                           => n981);
   U800 : OAI22_X1 port map( A1 => n914, A2 => n956, B1 => n904, B2 => n957, ZN
                           => n973);
   U801 : OAI22_X1 port map( A1 => n913, A2 => n956, B1 => n903, B2 => n957, ZN
                           => n965);
   U802 : OAI22_X1 port map( A1 => n912, A2 => n956, B1 => n902, B2 => n957, ZN
                           => n955);
   U803 : OAI22_X1 port map( A1 => n893, A2 => n910, B1 => n911, B2 => n919, ZN
                           => n292);
   U804 : OAI22_X1 port map( A1 => n892, A2 => n910, B1 => n911, B2 => n918, ZN
                           => n293);
   U805 : OAI22_X1 port map( A1 => n891, A2 => n910, B1 => n911, B2 => n917, ZN
                           => n294);
   U806 : OAI22_X1 port map( A1 => n890, A2 => n910, B1 => n911, B2 => n916, ZN
                           => n295);
   U807 : OAI22_X1 port map( A1 => n889, A2 => n910, B1 => n911, B2 => n915, ZN
                           => n296);
   U808 : OAI22_X1 port map( A1 => n888, A2 => n910, B1 => n911, B2 => n914, ZN
                           => n297);
   U809 : OAI22_X1 port map( A1 => n887, A2 => n910, B1 => n911, B2 => n913, ZN
                           => n298);
   U810 : OAI22_X1 port map( A1 => n885, A2 => n910, B1 => n911, B2 => n912, ZN
                           => n299);
   U811 : OAI22_X1 port map( A1 => n893, A2 => n900, B1 => n901, B2 => n909, ZN
                           => n300);
   U812 : OAI22_X1 port map( A1 => n892, A2 => n900, B1 => n901, B2 => n908, ZN
                           => n301);
   U813 : OAI22_X1 port map( A1 => n891, A2 => n900, B1 => n901, B2 => n907, ZN
                           => n302);
   U814 : OAI22_X1 port map( A1 => n890, A2 => n900, B1 => n901, B2 => n906, ZN
                           => n303);
   U815 : OAI22_X1 port map( A1 => n889, A2 => n900, B1 => n901, B2 => n905, ZN
                           => n304);
   U816 : OAI22_X1 port map( A1 => n888, A2 => n900, B1 => n901, B2 => n904, ZN
                           => n305);
   U817 : OAI22_X1 port map( A1 => n887, A2 => n900, B1 => n901, B2 => n903, ZN
                           => n306);
   U818 : OAI22_X1 port map( A1 => n885, A2 => n900, B1 => n901, B2 => n902, ZN
                           => n307);
   U819 : OAI22_X1 port map( A1 => n893, A2 => n926, B1 => n927, B2 => n935, ZN
                           => n268);
   U820 : OAI22_X1 port map( A1 => n892, A2 => n926, B1 => n927, B2 => n934, ZN
                           => n269);
   U821 : OAI22_X1 port map( A1 => n891, A2 => n926, B1 => n927, B2 => n933, ZN
                           => n270);
   U822 : OAI22_X1 port map( A1 => n890, A2 => n926, B1 => n927, B2 => n932, ZN
                           => n271);
   U823 : OAI22_X1 port map( A1 => n889, A2 => n926, B1 => n927, B2 => n931, ZN
                           => n272);
   U824 : OAI22_X1 port map( A1 => n888, A2 => n926, B1 => n927, B2 => n930, ZN
                           => n273);
   U825 : OAI22_X1 port map( A1 => n887, A2 => n926, B1 => n927, B2 => n929, ZN
                           => n274);
   U826 : OAI22_X1 port map( A1 => n885, A2 => n926, B1 => n927, B2 => n928, ZN
                           => n275);
   U827 : OAI22_X1 port map( A1 => n893, A2 => n936, B1 => n937, B2 => n945, ZN
                           => n260);
   U828 : OAI22_X1 port map( A1 => n892, A2 => n936, B1 => n937, B2 => n944, ZN
                           => n261);
   U829 : OAI22_X1 port map( A1 => n891, A2 => n936, B1 => n937, B2 => n943, ZN
                           => n262);
   U830 : OAI22_X1 port map( A1 => n890, A2 => n936, B1 => n937, B2 => n942, ZN
                           => n263);
   U831 : OAI22_X1 port map( A1 => n889, A2 => n936, B1 => n937, B2 => n941, ZN
                           => n264);
   U832 : OAI22_X1 port map( A1 => n888, A2 => n936, B1 => n937, B2 => n940, ZN
                           => n265);
   U833 : OAI22_X1 port map( A1 => n887, A2 => n936, B1 => n937, B2 => n939, ZN
                           => n266);
   U834 : OAI22_X1 port map( A1 => n885, A2 => n936, B1 => n937, B2 => n938, ZN
                           => n267);
   U835 : NOR2_X2 port map( A1 => n1059, A2 => ADD_RD1(1), ZN => n1024);
   U836 : NOR2_X2 port map( A1 => n1018, A2 => ADD_RD2(1), ZN => n951);
   U837 : NOR2_X2 port map( A1 => ADD_RD1(0), A2 => ADD_RD1(1), ZN => n1025);
   U838 : NOR2_X2 port map( A1 => ADD_RD2(0), A2 => ADD_RD2(1), ZN => n953);
   U839 : NAND3_X1 port map( A1 => ADD_WR(0), A2 => n896, A3 => n923, ZN => 
                           n924);
   U840 : NAND3_X1 port map( A1 => ADD_WR(1), A2 => n895, A3 => n923, ZN => 
                           n926);
   U841 : NAND3_X1 port map( A1 => ADD_WR(1), A2 => ADD_WR(0), A3 => n923, ZN 
                           => n936);
   U842 : NAND3_X1 port map( A1 => n897, A2 => n896, A3 => ADD_WR(0), ZN => 
                           n898);
   U843 : NAND3_X1 port map( A1 => n897, A2 => n895, A3 => ADD_WR(1), ZN => 
                           n900);
   U844 : NAND3_X1 port map( A1 => ADD_WR(0), A2 => n897, A3 => ADD_WR(1), ZN 
                           => n910);
   U845 : OAI222_X1 port map( A1 => n1054, A2 => n1020, B1 => n1055, B2 => 
                           n1022, C1 => n180, C2 => n1023, ZN => n244);
   U846 : AOI221_X1 port map( B1 => n1024, B2 => n1015, C1 => n1025, C2 => 
                           n1016, A => n1058, ZN => n1054);
   U847 : AOI221_X1 port map( B1 => n1024, B2 => n1012, C1 => n1025, C2 => 
                           n1013, A => n1057, ZN => n1055);
   U848 : OAI22_X1 port map( A1 => n945, A2 => n1027, B1 => n935, B2 => n1028, 
                           ZN => n1058);
   U849 : OAI222_X1 port map( A1 => n1050, A2 => n1020, B1 => n1051, B2 => 
                           n1022, C1 => n181, C2 => n1023, ZN => n245);
   U850 : AOI221_X1 port map( B1 => n1024, B2 => n1006, C1 => n1025, C2 => 
                           n1007, A => n1053, ZN => n1050);
   U851 : AOI221_X1 port map( B1 => n1024, B2 => n1003, C1 => n1025, C2 => 
                           n1004, A => n1052, ZN => n1051);
   U852 : OAI22_X1 port map( A1 => n944, A2 => n1027, B1 => n934, B2 => n1028, 
                           ZN => n1053);
   U853 : OAI222_X1 port map( A1 => n1046, A2 => n1020, B1 => n1047, B2 => 
                           n1022, C1 => n182, C2 => n1023, ZN => n246);
   U854 : AOI221_X1 port map( B1 => n1024, B2 => n998, C1 => n1025, C2 => n999,
                           A => n1049, ZN => n1046);
   U855 : AOI221_X1 port map( B1 => n1024, B2 => n995, C1 => n1025, C2 => n996,
                           A => n1048, ZN => n1047);
   U856 : OAI22_X1 port map( A1 => n943, A2 => n1027, B1 => n933, B2 => n1028, 
                           ZN => n1049);
   U857 : OAI222_X1 port map( A1 => n1042, A2 => n1020, B1 => n1043, B2 => 
                           n1022, C1 => n183, C2 => n1023, ZN => n247);
   U858 : AOI221_X1 port map( B1 => n1024, B2 => n990, C1 => n1025, C2 => n991,
                           A => n1045, ZN => n1042);
   U859 : AOI221_X1 port map( B1 => n1024, B2 => n987, C1 => n1025, C2 => n988,
                           A => n1044, ZN => n1043);
   U860 : OAI22_X1 port map( A1 => n942, A2 => n1027, B1 => n932, B2 => n1028, 
                           ZN => n1045);
   U861 : OAI222_X1 port map( A1 => n1038, A2 => n1020, B1 => n1039, B2 => 
                           n1022, C1 => n184, C2 => n1023, ZN => n248);
   U862 : AOI221_X1 port map( B1 => n1024, B2 => n982, C1 => n1025, C2 => n983,
                           A => n1041, ZN => n1038);
   U863 : AOI221_X1 port map( B1 => n1024, B2 => n979, C1 => n1025, C2 => n980,
                           A => n1040, ZN => n1039);
   U864 : OAI22_X1 port map( A1 => n941, A2 => n1027, B1 => n931, B2 => n1028, 
                           ZN => n1041);
   U865 : OAI222_X1 port map( A1 => n1034, A2 => n1020, B1 => n1035, B2 => 
                           n1022, C1 => n185, C2 => n1023, ZN => n249);
   U866 : AOI221_X1 port map( B1 => n1024, B2 => n974, C1 => n1025, C2 => n975,
                           A => n1037, ZN => n1034);
   U867 : AOI221_X1 port map( B1 => n1024, B2 => n971, C1 => n1025, C2 => n972,
                           A => n1036, ZN => n1035);
   U868 : OAI22_X1 port map( A1 => n940, A2 => n1027, B1 => n930, B2 => n1028, 
                           ZN => n1037);
   U869 : OAI222_X1 port map( A1 => n1030, A2 => n1020, B1 => n1031, B2 => 
                           n1022, C1 => n186, C2 => n1023, ZN => n250);
   U870 : AOI221_X1 port map( B1 => n1024, B2 => n966, C1 => n1025, C2 => n967,
                           A => n1033, ZN => n1030);
   U871 : AOI221_X1 port map( B1 => n1024, B2 => n963, C1 => n1025, C2 => n964,
                           A => n1032, ZN => n1031);
   U872 : OAI22_X1 port map( A1 => n939, A2 => n1027, B1 => n929, B2 => n1028, 
                           ZN => n1033);
   U873 : OAI222_X1 port map( A1 => n1019, A2 => n1020, B1 => n1021, B2 => 
                           n1022, C1 => n187, C2 => n1023, ZN => n251);
   U874 : AOI221_X1 port map( B1 => n1024, B2 => n958, C1 => n1025, C2 => n959,
                           A => n1029, ZN => n1019);
   U875 : AOI221_X1 port map( B1 => n1024, B2 => n952, C1 => n1025, C2 => n954,
                           A => n1026, ZN => n1021);
   U876 : OAI22_X1 port map( A1 => n938, A2 => n1027, B1 => n928, B2 => n1028, 
                           ZN => n1029);
   U877 : OAI222_X1 port map( A1 => n1009, A2 => n947, B1 => n1010, B2 => n949,
                           C1 => n188, C2 => n950, ZN => n252);
   U878 : AOI221_X1 port map( B1 => n951, B2 => n1015, C1 => n953, C2 => n1016,
                           A => n1017, ZN => n1009);
   U879 : AOI221_X1 port map( B1 => n951, B2 => n1012, C1 => n953, C2 => n1013,
                           A => n1014, ZN => n1010);
   U880 : OAI22_X1 port map( A1 => n945, A2 => n956, B1 => n935, B2 => n957, ZN
                           => n1017);
   U881 : OAI222_X1 port map( A1 => n1001, A2 => n947, B1 => n1002, B2 => n949,
                           C1 => n189, C2 => n950, ZN => n253);
   U882 : AOI221_X1 port map( B1 => n951, B2 => n1006, C1 => n953, C2 => n1007,
                           A => n1008, ZN => n1001);
   U883 : AOI221_X1 port map( B1 => n951, B2 => n1003, C1 => n953, C2 => n1004,
                           A => n1005, ZN => n1002);
   U884 : OAI22_X1 port map( A1 => n944, A2 => n956, B1 => n934, B2 => n957, ZN
                           => n1008);
   U885 : OAI222_X1 port map( A1 => n993, A2 => n947, B1 => n994, B2 => n949, 
                           C1 => n190, C2 => n950, ZN => n254);
   U886 : AOI221_X1 port map( B1 => n951, B2 => n998, C1 => n953, C2 => n999, A
                           => n1000, ZN => n993);
   U887 : AOI221_X1 port map( B1 => n951, B2 => n995, C1 => n953, C2 => n996, A
                           => n997, ZN => n994);
   U888 : OAI22_X1 port map( A1 => n943, A2 => n956, B1 => n933, B2 => n957, ZN
                           => n1000);
   U889 : OAI222_X1 port map( A1 => n985, A2 => n947, B1 => n986, B2 => n949, 
                           C1 => n191, C2 => n950, ZN => n255);
   U890 : AOI221_X1 port map( B1 => n951, B2 => n990, C1 => n953, C2 => n991, A
                           => n992, ZN => n985);
   U891 : AOI221_X1 port map( B1 => n951, B2 => n987, C1 => n953, C2 => n988, A
                           => n989, ZN => n986);
   U892 : OAI22_X1 port map( A1 => n942, A2 => n956, B1 => n932, B2 => n957, ZN
                           => n992);
   U893 : OAI222_X1 port map( A1 => n977, A2 => n947, B1 => n978, B2 => n949, 
                           C1 => n192, C2 => n950, ZN => n256);
   U894 : AOI221_X1 port map( B1 => n951, B2 => n982, C1 => n953, C2 => n983, A
                           => n984, ZN => n977);
   U895 : AOI221_X1 port map( B1 => n951, B2 => n979, C1 => n953, C2 => n980, A
                           => n981, ZN => n978);
   U896 : OAI22_X1 port map( A1 => n941, A2 => n956, B1 => n931, B2 => n957, ZN
                           => n984);
   U897 : OAI222_X1 port map( A1 => n969, A2 => n947, B1 => n970, B2 => n949, 
                           C1 => n193, C2 => n950, ZN => n257);
   U898 : AOI221_X1 port map( B1 => n951, B2 => n974, C1 => n953, C2 => n975, A
                           => n976, ZN => n969);
   U899 : AOI221_X1 port map( B1 => n951, B2 => n971, C1 => n953, C2 => n972, A
                           => n973, ZN => n970);
   U900 : OAI22_X1 port map( A1 => n940, A2 => n956, B1 => n930, B2 => n957, ZN
                           => n976);
   U901 : OAI222_X1 port map( A1 => n961, A2 => n947, B1 => n962, B2 => n949, 
                           C1 => n194, C2 => n950, ZN => n258);
   U902 : AOI221_X1 port map( B1 => n951, B2 => n966, C1 => n953, C2 => n967, A
                           => n968, ZN => n961);
   U903 : AOI221_X1 port map( B1 => n951, B2 => n963, C1 => n953, C2 => n964, A
                           => n965, ZN => n962);
   U904 : OAI22_X1 port map( A1 => n939, A2 => n956, B1 => n929, B2 => n957, ZN
                           => n968);
   U905 : OAI222_X1 port map( A1 => n946, A2 => n947, B1 => n948, B2 => n949, 
                           C1 => n195, C2 => n950, ZN => n259);
   U906 : AOI221_X1 port map( B1 => n951, B2 => n958, C1 => n953, C2 => n959, A
                           => n960, ZN => n946);
   U907 : AOI221_X1 port map( B1 => n951, B2 => n952, C1 => n953, C2 => n954, A
                           => n955, ZN => n948);
   U908 : OAI22_X1 port map( A1 => n938, A2 => n956, B1 => n928, B2 => n957, ZN
                           => n960);
   U909 : NAND2_X1 port map( A1 => ADD_RD1(2), A2 => n1023, ZN => n1020);
   U910 : NAND2_X1 port map( A1 => ADD_RD2(2), A2 => n950, ZN => n947);
   U911 : NAND2_X1 port map( A1 => n1023, A2 => n1056, ZN => n1022);
   U912 : INV_X1 port map( A => ADD_RD1(2), ZN => n1056);
   U913 : NAND2_X1 port map( A1 => n950, A2 => n1011, ZN => n949);
   U914 : INV_X1 port map( A => ADD_RD2(2), ZN => n1011);
   U915 : INV_X1 port map( A => DATAIN(0), ZN => n893);
   U916 : INV_X1 port map( A => DATAIN(1), ZN => n892);
   U917 : INV_X1 port map( A => DATAIN(2), ZN => n891);
   U918 : INV_X1 port map( A => DATAIN(3), ZN => n890);
   U919 : INV_X1 port map( A => DATAIN(4), ZN => n889);
   U920 : INV_X1 port map( A => DATAIN(5), ZN => n888);
   U921 : INV_X1 port map( A => DATAIN(6), ZN => n887);
   U922 : INV_X1 port map( A => DATAIN(7), ZN => n885);
   U923 : INV_X1 port map( A => RESET, ZN => n894);
   U924 : OAI22_X1 port map( A1 => n884, A2 => n893, B1 => n581, B2 => n886, ZN
                           => n316);
   U925 : OAI22_X1 port map( A1 => n884, A2 => n892, B1 => n579, B2 => n886, ZN
                           => n317);
   U926 : OAI22_X1 port map( A1 => n884, A2 => n891, B1 => n577, B2 => n886, ZN
                           => n318);
   U927 : OAI22_X1 port map( A1 => n884, A2 => n890, B1 => n575, B2 => n886, ZN
                           => n319);
   U928 : OAI22_X1 port map( A1 => n884, A2 => n889, B1 => n573, B2 => n886, ZN
                           => n320);
   U929 : OAI22_X1 port map( A1 => n884, A2 => n888, B1 => n571, B2 => n886, ZN
                           => n321);
   U930 : OAI22_X1 port map( A1 => n884, A2 => n887, B1 => n569, B2 => n886, ZN
                           => n322);
   U931 : OAI22_X1 port map( A1 => n884, A2 => n885, B1 => n567, B2 => n886, ZN
                           => n323);
   U932 : OAI22_X1 port map( A1 => n893, A2 => n898, B1 => n595, B2 => n899, ZN
                           => n308);
   U933 : OAI22_X1 port map( A1 => n892, A2 => n898, B1 => n594, B2 => n899, ZN
                           => n309);
   U934 : OAI22_X1 port map( A1 => n891, A2 => n898, B1 => n593, B2 => n899, ZN
                           => n310);
   U935 : OAI22_X1 port map( A1 => n890, A2 => n898, B1 => n592, B2 => n899, ZN
                           => n311);
   U936 : OAI22_X1 port map( A1 => n889, A2 => n898, B1 => n591, B2 => n899, ZN
                           => n312);
   U937 : OAI22_X1 port map( A1 => n888, A2 => n898, B1 => n590, B2 => n899, ZN
                           => n313);
   U938 : OAI22_X1 port map( A1 => n887, A2 => n898, B1 => n589, B2 => n899, ZN
                           => n314);
   U939 : OAI22_X1 port map( A1 => n885, A2 => n898, B1 => n588, B2 => n899, ZN
                           => n315);
   U940 : OAI22_X1 port map( A1 => n893, A2 => n921, B1 => n626, B2 => n922, ZN
                           => n284);
   U941 : OAI22_X1 port map( A1 => n892, A2 => n921, B1 => n625, B2 => n922, ZN
                           => n285);
   U942 : OAI22_X1 port map( A1 => n891, A2 => n921, B1 => n624, B2 => n922, ZN
                           => n286);
   U943 : OAI22_X1 port map( A1 => n890, A2 => n921, B1 => n623, B2 => n922, ZN
                           => n287);
   U944 : OAI22_X1 port map( A1 => n889, A2 => n921, B1 => n622, B2 => n922, ZN
                           => n288);
   U945 : OAI22_X1 port map( A1 => n888, A2 => n921, B1 => n621, B2 => n922, ZN
                           => n289);
   U946 : OAI22_X1 port map( A1 => n887, A2 => n921, B1 => n620, B2 => n922, ZN
                           => n290);
   U947 : OAI22_X1 port map( A1 => n885, A2 => n921, B1 => n619, B2 => n922, ZN
                           => n291);
   U948 : OAI22_X1 port map( A1 => n893, A2 => n924, B1 => n637, B2 => n925, ZN
                           => n276);
   U949 : OAI22_X1 port map( A1 => n892, A2 => n924, B1 => n636, B2 => n925, ZN
                           => n277);
   U950 : OAI22_X1 port map( A1 => n891, A2 => n924, B1 => n635, B2 => n925, ZN
                           => n278);
   U951 : OAI22_X1 port map( A1 => n890, A2 => n924, B1 => n634, B2 => n925, ZN
                           => n279);
   U952 : OAI22_X1 port map( A1 => n889, A2 => n924, B1 => n633, B2 => n925, ZN
                           => n280);
   U953 : OAI22_X1 port map( A1 => n888, A2 => n924, B1 => n632, B2 => n925, ZN
                           => n281);
   U954 : OAI22_X1 port map( A1 => n887, A2 => n924, B1 => n631, B2 => n925, ZN
                           => n282);
   U955 : OAI22_X1 port map( A1 => n885, A2 => n924, B1 => n630, B2 => n925, ZN
                           => n283);
   U956 : AND2_X1 port map( A1 => RD1, A2 => ENABLE, ZN => n1023);
   U957 : AND2_X1 port map( A1 => RD2, A2 => ENABLE, ZN => n950);
   U958 : AND3_X1 port map( A1 => WR, A2 => ENABLE, A3 => ADD_WR(2), ZN => n923
                           );
   U959 : AND3_X1 port map( A1 => ENABLE, A2 => n920, A3 => WR, ZN => n897);
   U960 : INV_X1 port map( A => ADD_WR(2), ZN => n920);
   U961 : INV_X1 port map( A => ADD_WR(1), ZN => n896);
   U962 : INV_X1 port map( A => ADD_WR(0), ZN => n895);
   U963 : INV_X1 port map( A => ADD_RD1(0), ZN => n1059);
   U964 : INV_X1 port map( A => ADD_RD2(0), ZN => n1018);

end SYN_A;
