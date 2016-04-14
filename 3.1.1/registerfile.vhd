library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use WORK.all;

entity register_file is
generic (npower : natural :=5;
          nbit : natural :=64);
 port ( CLK: 		IN std_logic;
    RESET: 	IN std_logic;
	 ENABLE: 	IN std_logic;
	 RD1: 		IN std_logic;
	 RD2: 		IN std_logic;
	 WR: 		IN std_logic;
	 ADD_WR: 	IN std_logic_vector(npower-1 downto 0);
	 ADD_RD1: 	IN std_logic_vector(npower-1 downto 0);
	 ADD_RD2: 	IN std_logic_vector(npower-1 downto 0);
	 DATAIN: 	IN std_logic_vector(nbit-1 downto 0);
         OUT1: 		OUT std_logic_vector(nbit-1 downto 0);
	 OUT2: 		OUT std_logic_vector(nbit-1 downto 0));
end register_file;

architecture A of register_file is

        -- suggested structures
        subtype REG_ADDR is natural range 0 to 31; -- using natural type
	type REG_ARRAY is array(REG_ADDR) of std_logic_vector(63 downto 0); 
	signal REGISTERS : REG_ARRAY;

    signal R1_AddrInt  : natural range 0 to 31; 
    signal R2_AddrInt  : natural range 0 to 31; 
    signal W_AddrInt  : natural range 0 to 31; 

	
begin 
-- write your RF code
R1_AddrInt  <=  to_integer (unsigned (add_rd1));
  R2_AddrInt  <=  to_integer (unsigned (add_rd2));
  W_AddrInt  <=  to_integer (unsigned (add_wr));
  
p0 : process (clk)

begin
    if (clk='1' and clk'event) then
            
              --synchronous reset
              if reset='1' then
                for i in 0 to (2**npower)-1 loop
                registers(I) <= (others=>'0');
                end loop;
              end if;
              --synchronous read/write with high enable signal
              if (enable='1') then 
                    if rd1='1' then
                    out1 <= registers(  R1_AddrInt);
                    end if;
                    if rd2='1' then
                    out2 <= registers(  R2_AddrInt);
                    end if;
                    if wr='1' then
                    REGISTERS(  W_AddrInt) <=datain;
                    end if;
              end if;
              
       end if;

end process;


end A;

----


configuration CFG_RF_BEH of register_file is
  for A
  end for;
end configuration;
