library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity windowed_reg is
generic (
          M : integer :=4; 		--number global registers	
          N : integer :=4; 		--number of registers in each of the IN/OUT/LOCAL window
		  F : integer :=4; 		--number of window
          naddr : integer :=2; 	--lenght of the address signal = log2(3*N+M)
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
        RET: 	    IN std_logic;
		
		--signal to/from memory
		--memory subroutine management
        FILL: 		OUT std_logic;
        SPILL: 	    OUT std_logic;
        
        DATA_FORM_MEM : IN std_logic_vector(nbit-1 downto 0);	--data to restore from mem
        DATA_TO_MEM :	OUT std_logic_vector(nbit-1 downto 0)		--data to store to mem
);
end windowed_reg;

architecture Behavioral of windowed_reg is

constant TotalRegisters:	integer:= F*3*N;	--total registers IN/LOCAL/OUT
subtype REG_ADDR is integer range 0 to (TotalRegisters+M-1); -- using integer type
type REG_ARRAY is array(REG_ADDR) of std_logic_vector(nbit-1 downto 0); 
signal REGISTERS 	: REG_ARRAY;
	
--internal registers
signal SWP, CWP 	: integer range 0 to (TotalRegisters)-1; 
signal CANSAVE, CANRESTORE : std_logic;
signal internalIndex: integer range 0 to (2*N)-1; 
signal Storing: std_logic; 

--ADDRESS FOR THE REGISTER
signal R1_AddrInt	: integer range 0 to (2**naddr)-1; 
signal R2_AddrInt	: integer range 0 to (2**naddr)-1; 
signal W_AddrInt	: integer range 0 to (2**naddr)-1; 

begin
R1_AddrInt 	 <=  to_integer (unsigned (ADD_RD1));
R2_AddrInt 	 <=  to_integer (unsigned (ADD_RD2));
W_AddrInt 	 <=  to_integer (unsigned (ADD_WR));

	P0 : process (CLK)
	begin
		if (CLK='1' and CLK'event) then	
			--synchronous reset
			if RESET='1' then
				for I in 0 to TotalRegisters+M-1 loop
				REGISTERS(I) <= (others => '0');
				end loop;
				--internal signals
				SWP <= 0;
				CWP <= 0;
				CANSAVE <= '1';
				CANRESTORE <= '1';
				internalIndex <= 0;
				memoryIndex <= 0;
				
				--external signals
				OUT1 <= (others => Z);
				OUT2 <= (others => Z);
				BUS_TO_MEM <= (others => Z);
				DATA_TO_MEM <= (others => Z);
		
			--synchronous read/write with high enable signal
			elsif ENABLE='1' then 
			
				
				if CALL='0' and RET='0' then
					--Within a subroutine
					if RD1='1' then
						OUT1 <= REGISTERS(CWP + R1_AddrInt);
					end if;
					if RD2='1' then
						OUT2 <= REGISTERS(CWP + R2_AddrInt);
					end if;
					if WR='1' then
						REGISTERS(CWP + W_AddrInt) <= DATAIN;
					end if;
					
				elsif CALL='1' and RET='0' then	--call
					if Storing = '1' then --serve per salvare ad ogni clock gli 2*N registri
						if CWP mod 2*N /= 0 then --finche non salva 2*N registri continua
							CWP <= CWP + 1; --incrementa di uno il CWP e il registro indirrizzato lo salva in memoria
							DATA_TO_MEM <= OUT1 <= REGISTERS(CWP);
						else
							SPILL <= '0'; --quando ha salvato 2*N registri ababssa il segnale di SPILL e di Storing
							Storing <= '0';
						end if;
					else
						CWP <= CWP + (2*N) mod (TotalRegisters); --è ancora possibile salvare nel register file
					end if;
					
					if CWP = TotalRegisters - 2*N or CANSAVE = '0' then --se si è arrivati all'ultimo slot libero oppure se sono richieste altre call dopo che la fine è stata superatata
						CANSAVE <= '0';
						--memorize the next IN/LOCAL in memory
						SPILL <= '1'; --va in output alla MMU
						Storing <= '1'; --segnale interno
						
						SWP <= SWP + (2*N) mod (TotalRegisters);--aggiorno il SWP (uso il mod cosi se arrivo al max lui riparte da 0)
					end if;
				
				elsif CALL='0' and RET='1' then
					CWP <= CWP - (2*N);
				
				-- elsif CALL='0' and RET='0' and FILL='1' and SPILL='0' then	--restore from memory
					-- if CANRESTORE='1' then
						-- CWP <= (CWP - (2*N)-1)  mod (F*N) ;	--USO IL MOD COSI CHE QUANDO SUPERO IL MASSIMO (F*N) RITORNA A 0
						-- SWP <= (SWP - (2*N)-1) mod (F*N) ;
					-- end if
				
				-- elsif CALL='0' and RET='0' and FILL='0' and SPILL='1' then	--store to memory
					-- if CANSAVE='1' then
						-- WRITE_M <= '1';
						-- ADD_M <= std_logic_vector(memoryIndex + internalIndex);
						-- DATA_TO_MEM <= REGISTERS(CWP + internalIndex);
						-- internalIndex <= internalIndex + 1;
						-- if internalIndex = 2*N then
						-- CWP <= (CWP + (2*N)-1) mod (F*N) ;
						-- SWP <= (SWP + (2*N)-1) mod (F*N) ;
						-- memoryIndex <= 2*N;
						-- end if;
					-- end if
				
				end if;
				
			end if;
				  
		end if;
	end process;


end Behavioral;

