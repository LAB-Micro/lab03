library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity windowed_reg is
generic (
          M : natural :=4; 		--number global registers	
          N : natural :=4; 		--number of registers in each of the IN/OUT/LOCAL window
		  F : natural :=4; 		--number of window
          naddr : natural :=2; 	--lenght of the address signal = log2(3*N+M)
          nbit : natural := 8 	--width of each register
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
        RET: 	    IN std_logic; --return is a key word, not available
                
        --signal to/from memory
        -- update the CWP register by register: you must suppose to spill one register at each clock cycle
        BUS_TO_MEM : out std_logic_vector(1 downto 0);		-- bus output: 
															-- 01: SPILL to Memory
															-- 10: FILL from Memory
        DATA_FORM_MEM : in std_logic_vector(nbit-1 downto 0);	--data to restore from mem
        DATA_TO_MEM : out std_logic_vector(nbit-1 downto 0)		--data to store to mem
);
end windowed_reg;

architecture Behavioral of windowed_reg is

subtype REG_ADDR is natural range 0 to (F*3*N+M-1); -- using natural type
type REG_ARRAY is array(REG_ADDR) of std_logic_vector(nbit-1 downto 0); 
signal REGISTERS : REG_ARRAY;
	
--internal registers
signal SWP, CWP : natural :=0; 
signal CANSAVE, CANRESTORE : std_logic;

--ADDRESS FOR THE REGISTER
signal R1_AddrInt  : natural range 0 to (2**naddr)-1; 
signal R2_AddrInt  : natural range 0 to (2**naddr)-1; 
signal W_AddrInt  : natural range 0 to (2**naddr)-1; 

begin
R1_AddrInt 	 <=  to_integer (unsigned (ADD_RD1));
R2_AddrInt 	 <=  to_integer (unsigned (ADD_RD2));
W_AddrInt 	 <=  to_integer (unsigned (ADD_WR));
  
	P0 : process (CLK)
	begin
		if (CLK='1' and CLK'event) then	
			--synchronous reset
			if RESET='1' then
				for I in 0 to F*N+M-1 loop
				REGISTERS(I) <= (others => '0');
				end loop;
				--internal signals
				SWP <= 0;
				CWP <= 0;
				CANSAVE <= '0';
				CANRESTORE <= '0';
				
				--external signals
				OUT1 <= (others => Z);
				OUT2 <= (others => Z);
				BUS_TO_MEM <= (others => Z);
				DATA_TO_MEM <= (others => Z);
		
			--synchronous read/write with high enable signal
			elsif ENABLE='1' then 
			
				--Within a subroutine
				if RD1='1' then
					OUT1 <= REGISTERS(R1_AddrInt);
                end if;
                if RD2='1' then
                    OUT2 <= REGISTERS(R2_AddrInt);
                end if;
                if WR='1' then
                    REGISTERS(W_AddrInt) <=DATAIN;
                end if;
				
			end if;
				  
		end if;
	end process;


end Behavioral;

