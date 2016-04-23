library IEEE;

use IEEE.std_logic_1164.all;

entity TBWINDOWREGISTERFILE is
end TBWINDOWREGISTERFILE;

architecture TESTW of TBWINDOWREGISTERFILE is
	
       signal CLK: std_logic := '0';
       signal RESET: std_logic;
       signal ENABLE: std_logic;
       signal RD1: std_logic;
       signal RD2: std_logic;
       signal WR: std_logic;
       signal ADD_WR: std_logic_vector(4 downto 0);
       signal ADD_RD1: std_logic_vector(4 downto 0);
       signal ADD_RD2: std_logic_vector(4 downto 0);
       signal DATAIN: std_logic_vector(7 downto 0);
       signal OUT1: std_logic_vector(7 downto 0);
       signal OUT2: std_logic_vector(7 downto 0);
       signal CALL: std_logic;
       signal RET: std_logic;
       signal FILL: std_logic;
       signal SPILL: std_logic;
       signal DATA_FROM_MEM: std_logic_vector(7 downto 0);
       signal DATA_TO_MEM: std_logic_vector(7 downto 0);

component windowed_reg
generic (
          M : integer :=4; 		--number global registers	
          N : integer :=4; 		--number of registers in each of the IN/OUT/LOCAL window
          F : integer :=4; 		--number of window
          naddr : integer :=4; 	--lenght of the address signal = log2(3*N+M)
          naddrMem : integer :=16; 	--lenght of the memory
          nbit : integer := 8 	--width of each register
          );
port(

        CLK:		IN std_logic;
        RESET: 	 	IN std_logic; --reset all the RF
        ENABLE: 	IN std_logic;
        RD1: 		IN std_logic;
        RD2:  		IN std_logic;
        WR: 	  	IN std_logic;
        ADD_WR: 	IN std_logic_vector(naddr-1 downto 0);
        ADD_RD1: 	IN std_logic_vector(naddr-1 downto 0);
        ADD_RD2: 	IN std_logic_vector(naddr-1 downto 0);
        DATAIN: 	IN std_logic_vector(nbit-1 downto 0);
        OUT1: 		OUT std_logic_vector(nbit-1 downto 0);
        OUT2: 		OUT std_logic_vector(nbit-1 downto 0);

        --subroutine management
        CALL: 		IN std_logic;
        RET: 	   	IN std_logic;
		
		--signal to/from memory
		--memory subroutine management
        FILL: 		OUT std_logic;
        SPILL: 	    	OUT std_logic;
        
        DATA_FROM_MEM : IN std_logic_vector(nbit-1 downto 0);	--data to restore from mem
        DATA_TO_MEM :	OUT std_logic_vector(nbit-1 downto 0)		--data to store to mem
);
end component;

begin 

RG:windowed_reg
GENERIC MAP(4,4,4,5,16,8)
PORT MAP (CLK,RESET,ENABLE,RD1,RD2,WR,ADD_WR,ADD_RD1,ADD_RD2,DATAIN,OUT1,OUT2,CALL,RET,FILL,SPILL,DATA_FROM_MEM,DATA_TO_MEM);
	RESET 	<= '1','0' after 5 ns;
	ENABLE 	<= '0','1' after 3 ns, '0' after 10 ns, '1' after 15 ns;
	WR 	<= '0';
  --'1' after 6 ns, '0' after 7 ns, '1' after 10 ns, '0' after 20 ns;
	RD1 	<= '1','0' after 5 ns, '1' after 13 ns, '0' after 20 ns; 
	RD2 	<= '0','1' after 17 ns;
	ADD_WR 	<= "00000", "00001" after 9 ns, "00010" after 12 ns, "00011" after 16 ns, "00100" after 18 ns, "00101" after 22 ns, "00110" after 25 ns;
	ADD_RD1 <="10110", "01000" after 9 ns;
	ADD_RD2	<= "11100", "01000" after 9 ns, "00000" after 200 ns, "00010" after 203 ns, "01000" after 206 ns, "01010" after 210 ns, "01110" after 215 ns; --the last one is a global variable
	DATAIN	<=(others => '0'); 
  --(7 downto 3 => '0') & "001" after 8 ns, (7 downto 3 => '0') & "010" after 11 ns, (7 downto 3 => '0') & "011" after 15 ns, (7 downto 3 => '0') & "100" after 17 ns, (7 downto 3 => '0') & "101" after 21 ns, (7 downto 3 => '0') & "110" after 24 ns;
--	CALL	<= '0', 
--        '1' after 17 ns, 
--        '0' after 18 ns, 
--        '1' after 19 ns, 
--        '0' after 21 ns, 
--        '1' after 23 ns,
--        '0' after 24 ns, 
--        '1' after 27 ns, 
--        '0' after 28 ns, 
--        '1' after 31 ns, 
--        '0' after 32 ns, 
--        '1' after 41 ns, 
--        '0' after 42 ns, 
--        '1' after 61 ns, 
--        '0' after 62 ns, 
--        '1' after 72 ns, 
--        '0' after 73 ns, 
--        '1' after 84 ns, 
--        '0' after 85 ns;	
        CALL <= '0', '1' after 17 ns, '0' after 18 ns, '1' after 25 ns, '0' after 26 ns, '1' after 30 ns, '0' after 31 ns, '1' after 35 ns, '0' after 36 ns, 
      '1' after 43 ns, '0' after 44 ns, '1' after 45 ns, '0' after 46 ns, '1' after 49 ns, '0' after 50 ns, '1' after 63 ns, '0' after 64 ns;
	RET  <= '0', '1' after 3 ns, '0' after 4 ns, '1' after 20 ns, '0' after 21 ns, '1' after 22 ns, '0' after 23 ns, '1' after 27 ns, '0' after 28 ns, '1' after 40 ns, '0' after 41 ns,
            '1' after 80 ns, '0' after 81 ns, '1' after 100 ns, '0' after 101 ns, '1' after 120 ns, '0' after 121 ns, '1' after 150 ns, '0' after 151 ns;
	DATA_FROM_MEM <= (others => '0'), x"7B" after 80 ns;--123
  

	PCLOCK : process(CLK)
	begin
		CLK <= not(CLK) after 0.5 ns;	
	end process;

end TESTW;

-- 
-- configuration CFG_TESTRF of TBWINDOWREGISTERFILE is
--   for TESTW
-- 	for RG : windowed_reg
-- 		use configuration WORK.CFG_RF_BEH;
-- 	end for; 
--   end for;
-- end CFG_TESTRF;
