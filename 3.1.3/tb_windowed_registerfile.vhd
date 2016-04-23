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
       signal ADD_WR: std_logic_vector(3 downto 0);
       signal ADD_RD1: std_logic_vector(3 downto 0);
       signal ADD_RD2: std_logic_vector(3 downto 0);
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
          naddr : integer :=2; 	--lenght of the address signal = log2(3*N+M)
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
GENERIC MAP(4,4,4,4,8)	--I have to handle 4 (general register)+ 4(register for IN/LOCAL/OUT)*3 = 16 ---> I need 2**4 = 16 address
PORT MAP (CLK,RESET,ENABLE,RD1,RD2,WR,ADD_WR,ADD_RD1,ADD_RD2,DATAIN,OUT1,OUT2,CALL,RET,FILL,SPILL,DATA_FROM_MEM,DATA_TO_MEM);
	RESET 	<= '1','0' after 2 ns;

	--1st configuration: 
	--			1. WRITE SOME VALUE (THE ADDRESS '1100' (12) IS THE FIRST REGISTER OF THE GLOBAL REGISTER)
	--			2. READ THEM (THE FIRST TWO IN THE OUT1, THE OTHERS IN OUT2)
	--			3. CALL
	--			4. READ THE PREVIUS ADRRESS
	--			5. CALL
	--			6. CALL (SPILL)
	--			7. RETURN
	--			8. RETURN
	--			9. RETURN (FILL, CWP = 0) 

	ENABLE 	<= '0','1' after 3 ns;
	WR 	<= '0','1' after 3 ns, '0' after 4 ns, '1' after 6 ns, '0' after 7 ns, '1' after 10 ns, '0' after 11 ns, '1' after 17 ns, '0' after 18 ns;
	RD1 	<= '0','1' after 20 ns; 
	RD2 	<= '0','1' after 20 ns;
	ADD_WR 	<= "0001", "0011" after 5 ns, "0010" after 9 ns, "1100" after 16 ns;
	ADD_RD1 	<= (others => '0'), "0001" after 20 ns, "0011" after 25 ns, "0001" after 35 ns, "0011" after 40 ns;
	ADD_RD2 	<= (others => '0'), "0010" after 20 ns, "1100" after 25 ns, "0010" after 35 ns, "1100" after 40 ns;
	DATAIN	<= "00001000", "00001001" after 5 ns, "00001101" after 9 ns, "00101001" after 16 ns;
	DATA_FROM_MEM <= (others => '0'), "00001001" after 60 ns;
	CALL <= '0', '1' after 30 ns, '0' after 31 ns, '1' after 42 ns, '0' after 43 ns, '1' after 44 ns, '0' after 45 ns;
	RET  <= '0', '1' after 55 ns, '0' after 56 ns, '1' after 58 ns, '0' after 59 ns, '1' after 60 ns, '0' after 61 ns;

	--2nd configuration: DECCOMENT FROM THE windowed_reg THE LIBRARY ARITH AND THE OPERATIONS IN THE READ/WRITE CASE
	--		:    READ ALL CELL BEFORE AND AFTER CALLS
-- 	ENABLE 	<= '0','1' after 3 ns;
-- 	WR 	<= '0';
-- 	RD1 	<= '1';	
-- 	RD2	<= '0';	
-- 	ADD_WR <= "0000";
-- 	ADD_RD1 <="0000", "0001" after 9 ns, "0010" after 11 ns, "0011" after 13 ns, "0100" after 15 ns, "0101" after 17 ns, "0110" after 19 ns, "0111" after 21 ns, "1000" after 23 ns, "1001" after 25 ns, "1010" after 27 ns, "1011" after 29 ns, "1100" after 31 ns, "1101" after 33 ns, "1110" after 35 ns, "1111" after 37 ns, "0000" after 55 ns, "0001" after 56 ns, "0010" after 57 ns, "0011" after 58 ns, "0100" after 59 ns, "0101" after 60 ns, "0110" after 61 ns, "0111" after 62 ns, "1000" after 63 ns, "1001" after 64 ns, "1010" after 65 ns, "1011" after 66 ns, "1100" after 67 ns, "1101" after 68 ns, "1110" after 69 ns, "1111" after 70 ns;
-- 	ADD_RD2 <= "0000";	
-- 	DATAIN	<=(others => '0');
-- 	CALL <= '0', '1' after 40 ns, '0' after 41 ns, '1' after 42 ns, '0' after 43 ns, '1' after 44 ns, '0' after 45 ns;
-- 	RET <= '0';
-- 	DATA_FROM_MEM <= (others => '0');


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
