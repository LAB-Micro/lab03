library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
	
entity windowed_reg is
generic (
	M : integer :=4; 	--number global registers	
	N : integer :=4; 	--number of registers in each of the IN/OUT/LOCAL window
	F : integer :=4; 	--number of window
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
end windowed_reg;

architecture Behavioral of windowed_reg is

constant TotalRegisters:	integer:= F*2*N;	--total registers IN/LOCAL/OUT

subtype REG_ADDR is integer range 0 to (TotalRegisters-1); -- using integer type
type REG_ARRAY is array(REG_ADDR) of std_logic_vector(nbit-1 downto 0); 
signal REGISTERS 	: REG_ARRAY;

subtype GL_REG_ADDR is integer range 0 to (M-1); -- using integer type
type GL_REG_ARRAY is array(GL_REG_ADDR) of std_logic_vector(nbit-1 downto 0); 
signal GLOBAL_REGISTERS : GL_REG_ARRAY;
	
--internal registers
--signal SWP, CWP 	: integer range 0 to (TotalRegisters)-1; 
signal SWP, CWP 	: integer range 0 to TotalRegisters; 
signal CANSAVE, CANRESTORE : std_logic;
signal Storing: std_logic;
signal firstStoring: std_logic;
signal Restoring: std_logic;
signal counter: integer;

--ADDRESS FOR THE REGISTER
signal R1_AddrInt	: integer range 0 to (2**naddr)-1; 
signal R2_AddrInt	: integer range 0 to (2**naddr)-1; 
signal W_AddrInt	: integer range 0 to (2**naddr)-1; 

function increasePointerBuffer(WP: integer) return integer is
	variable tmp: integer;
	begin
	tmp := (WP + (2*N)) mod (TotalRegisters);
	return tmp;
end increasePointerBuffer;

function decreasePointerBuffer(WP: integer) return integer is
	variable tmp: integer;
	begin
	if WP = 0 then
		tmp := TotalRegisters - 2*N;
	else 
		tmp := WP - (2*N);
	end if;
	return tmp;
end decreasePointerBuffer;

begin

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
				CANRESTORE <= '0';
				Storing <= '0';
				firstStoring <= '1';
				Restoring <= '0';
				counter <= 0;
				
				--external signals
				OUT1 <= (others => 'Z');
				OUT2 <= (others => 'Z');
				DATA_TO_MEM <= (others => 'Z');
				FILL <= '0';
				SPILL <= '0';
		
			--synchronous read/write with high enable signal
			elsif ENABLE='1' then 
				
				if Storing = '0' and Restoring = '0' then
					if CALL='0' and RET='0' then
						--Within a subroutine
						R1_AddrInt 	 <=  conv_integer(ADD_RD1);
						R2_AddrInt 	 <=  conv_integer(ADD_RD2);
						W_AddrInt 	 <=  conv_integer(ADD_WR);
						if RD1='1' then
							if R1_AddrInt > (3*N) then	--access to the GLOBAL REGISTER
								OUT1 <= GLOBAL_REGISTERS((2**naddr)-1 - R1_AddrInt);
							else
								OUT1 <= REGISTERS((CWP + R1_AddrInt) mod (3*N));
							end if;
						end if;
						if RD2='1' then
							if R2_AddrInt > (3*N) then	--access to the GLOBAL REGISTER
								OUT1 <= GLOBAL_REGISTERS((2**naddr)-1 - R2_AddrInt);
							else
								OUT1 <= REGISTERS((CWP + R2_AddrInt) mod (3*N));
							end if;
						end if;
						if WR='1' then
							if W_AddrInt > (3*N) then	--access to the GLOBAL REGISTER
								GLOBAL_REGISTERS((2**naddr)-1 - R2_AddrInt) <= DATAIN;
							else
								REGISTERS((CWP + R2_AddrInt) mod (3*N)) <= DATAIN;
							end if;
						end if;
	
					elsif CALL='1' and RET='0'then	--call
						
						CWP <= increasePointerBuffer(CWP); --incrementa il CWP
						CANRESTORE <= '1';

						if CWP = (TotalRegisters - 2*N) then
							counter <= counter + 1;
						end if;
				
						if CWP = (TotalRegisters - 4*N) or CANSAVE = '0' then --se si è arrivati all'ultimo slot libero oppure se sono richieste altre call dopo che la fine è stata superatata
							CANSAVE <= '0';
							--memorize the next IN/LOCAL in memory
							SPILL <= '1'; --va in input alla MMU
							Storing <= '1'; --segnale interno
						end if;
					
					elsif CALL='0' and RET='1' then --return
						
						if CANRESTORE = '1' then
							if CWP = 0 and CANSAVE = '1' and counter = 0 then --se il risultato sarà 0 non sarà possibile piu fare un altro return
								CANRESTORE <= '0';	--non è possibile fare un return fino a una CALL
							else
								CWP <= decreasePointerBuffer(CWP); --è ancora possibile tornare indietro nel register file senza prelevare
								if counter = 0 then
									CANSAVE <= '1';
								end if;

								if  CWP = SWP then --condizione per la quale è necessario fare FILL dalla memoria. La condizione CANSAVE = '0' serve per non fare la FILL quando si fa call-ret-ret
									FILL <= '1'; --va in input alla MMU
									Restoring <= '1';
								--tempCWP <= CWP;
								--SWP <= decreasePointerBuffer(SWP);
								end if;
							end if;

							if CWP = 0 and counter /= 0 then
								counter <= counter - 1;
							end if;

						end if;	
					end if;

				elsif Storing = '1' then --serve per salvare ad ogni clock gli 2*N registri

					if firstStoring = '1' or (SWP mod (2*N)) /= 0  then
						DATA_TO_MEM <= REGISTERS(SWP);
						SWP <= (SWP + 1) mod TotalRegisters;	--aggiorna il valore di SWP e lo incrementa fino a 2*N 
						firstStoring <= '0';
					else
						SPILL <= '0'; --quando ha salvato 2*N registri ababssa il segnale di SPILL e di Storing
						Storing <= '0';
						firstStoring <= '1';
						DATA_TO_MEM <= (others => 'Z');
					end if;
					
				elsif Restoring = '1' then --finche non restore 2*N registri continua
					if firstStoring = '1' or (SWP mod (2*N)) /= 0  then
						REGISTERS(SWP) <= DATA_FROM_MEM;			--il dato dalla memoria lo salva nel registro 
						
						if SWP = 0 then
							SWP <= TotalRegisters - 1;
						else
							SWP <= (SWP - 1);	--decrementa di uno il SWP
						end if;
						firstStoring <= '0';
					else
						FILL <= '0'; --quando ha salvato 2*N registri ababssa il segnale di FILL e di Storing
						Restoring <= '0';
						firstStoring <= '1';
					end if;

				end if;
			end if;
				  
		end if;
	end process;


end Behavioral;

