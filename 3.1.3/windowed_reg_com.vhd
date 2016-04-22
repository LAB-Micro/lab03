library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
	
entity windowed_reg is
generic (
	M : integer :=4; 	--number global registers	
	N : integer :=4; 	--number of registers in each of the IN/OUT/LOCAL window
	F : integer :=4; 	--number of window
  naddrMem : integer :=16; --
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

constant TotalRegisters:	integer:= F*2*N+N;	--total registers IN/LOCAL/OUT
--2 consecutive windows share the same block IN/OUT, so i will count it only once.
--for each block, i consider the block LOCAL and the shared block IN/OUT ==>F*2*N
--i add N, because the block IN of the first window is not shared.

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
signal counterReg : integer;

--ADDRESS FOR THE REGISTER
signal R1_AddrInt	: integer range 0 to (2**naddr)-1; 
signal R2_AddrInt	: integer range 0 to (2**naddr)-1; 
signal W_AddrInt	: integer range 0 to (2**naddr)-1; 


function increaseSavedWindowPointer(SWP: integer) return integer is
	variable tmp: integer;
	begin
  if (tmp=(F-1)*2*N) then tmp:=0;
  else	tmp := (SWP + (2*N));
  end if;
	return tmp;
end increaseSavedWindowPointer;



function increasePointerBuffer(WP: integer) return integer is
	variable tmp: integer;
	begin
  if (tmp=(F-1)*2*N) then tmp:=0;
  else	tmp := (WP + (2*N));
  end if;
	return tmp;
end increasePointerBuffer;
--The IN block is always pointed by 0, 2N, 4N...(F-1)*2*N)
--the last window, (window number F) starts with (F-1)*2*N).
--when we are in the last window and if we want to make another call, we have come back to the window 0, so
--we have to point to 0. We cannot point to F*2*N, because it point to the OUT block of the last window and 
--is not shared to the IN block of the next window (we go to have to go to window 0)


function decreasePointerBuffer(WP: integer) return integer is
	variable tmp: integer;
	begin
	if WP = 0 then
		tmp := (F-1)*2*N;
	else 
		tmp := WP - (2*N);
	end if;
	return tmp;
end decreasePointerBuffer;
--we considered the case when we want to call, for example, 3*F times.
--in this case when calling, we point to 0, 2N, 4N....(F-1)*2*N), 0, 2N, 4N...(F-1)*2*N), 0, 2N, 4N...(F-1)*2*N)
--When we make return 3*F times, the pointer should decrease in this way
--(F-1)*2*N).....4N, 2N, 0,(F-1)*2*N)......4N, 2N, 0,(F-1)*2*N).....4N, 2N, 0,

begin

	P0 : process (CLK)
	begin
		if (CLK='1' and CLK'event) then	
			--synchronous reset
			if RESET='1' then
        --reset of ALL the IN/out/local registers of ALL the windows
				for I in 0 to TotalRegisters-1 loop --modificato perch� out of array, REGISTERS[0...TotalRegisters-1], no TotalRegisters+M
				REGISTERS(I) <= (others => '0');
				end loop;
        
        --reset of global registers
        for I in 0 to M-1 loop
        GLOBAL_REGISTERS(i)<= (others => '0');
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
        counterReg <=0;
				
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
            
            
            --FIRST READING
						if RD1='1' then
							if R1_AddrInt >= (3*N) then	--access to the GLOBAL REGISTER
								--OUT1 <= GLOBAL_REGISTERS((2**naddr)-1 - R1_AddrInt);
                OUT1 <= GLOBAL_REGISTERS(R1_AddrInt-(3*N));
							else
								--OUT1 <= REGISTERS((CWP + R1_AddrInt) mod (3*N));
                OUT1 <= REGISTERS(CWP + R1_AddrInt);
                --REGISTERS[0,1...F*2*N+N-1]
                --the max value of CWP is (F-1)*2*N
                --the max value of R1_AddrInt in this else-branch is 3N-1
                --(CWP + R1_AddrInt) in the max case ==> (F-1)*2*N+3N-1 ==> F*2*N+N-1
                --no out of bondary for the REGISTERS type signal.
							end if;
						end if;
            
              --SECOND READING
              if RD2='1' then
                  if R2_AddrInt >= (3*N) then	--access to the GLOBAL REGISTER
                    --OUT2 <= GLOBAL_REGISTERS((2**naddr)-1 - R1_AddrInt);
                    OUT2 <= GLOBAL_REGISTERS(R1_AddrInt-(3*N));
                  else
                    --OUT2 <= REGISTERS((CWP + R1_AddrInt) mod (3*N));
                    OUT2 <= REGISTERS(CWP + R1_AddrInt);
                    --REGISTERS[0,1...F*2*N+N-1]
                    --the max value of CWP is (F-1)*2*N
                    --the max value of R1_AddrInt in this else-branch is 3N-1
                    --(CWP + R1_AddrInt) in the max case ==> (F-1)*2*N+3N-1 ==> F*2*N+N-1
                    --no out of bondary for the REGISTERS type signal.
                  end if;	
              end if;
              
              --WRITING
              if WR='1' then
                      if W_AddrInt >= (3*N) then	--access to the GLOBAL REGISTER
                        GLOBAL_REGISTERS(W_AddrInt-(3*N)) <= DATAIN;
                      else
                        REGISTERS(CWP + W_AddrInt) <= DATAIN;
                      end if;
              end if;
	
					elsif CALL='1' and RET='0'then	--call
						
						CWP <= increasePointerBuffer(CWP); --incrementa il CWP
						CANRESTORE <= '1';

						--if CWP = (TotalRegisters - 2*N) then
            if CWP = 0 then
            counter <= counter + 1; 
            --if we make a call and the increased CWP = 0 (it points to the IN block of the first window),
            --it means that we finish the first/another round of all the available windows.
            --we want to store the number of the round completed.
            --example: when we call F, 2F, 3F... times, we set the counter to 1, 2, 3...
						end if;
				
        
            --if CWP = (TotalRegisters - 4*N) or CANSAVE = '0' then 
            --se si � arrivati all'ultimo slot libero oppure se sono richieste altre call dopo che la fine � stata superatata
						if CWP = (F-1)*2*N then 
            --when we make a call and we jump to the last window (CWP = (F-1)*2*N, pointer of IN block of last window)
            --we have to store into memory the window 0.
            
						CANSAVE <= '0';
							--memorize the next IN/LOCAL in memory
							SPILL <= '1'; --va in input alla MMU
							Storing <= '1'; --segnale interno
              --DOMANDA:spill, spill the register spill=svuotare
						end if;
					
					elsif CALL='0' and RET='1' then --return
						
						if CANRESTORE = '1' then
            --DOMANDA, il cansave nell'if e' necessario?
							if CWP = 0 and CANSAVE = '1' and counter = 0 then --se il risultato sar� 0 non sar� possibile piu fare un altro return
								CANRESTORE <= '0';	--non � possibile fare un return fino a una CALL
							else
								CWP <= decreasePointerBuffer(CWP); --� ancora possibile tornare indietro nel register file senza prelevare                      
                        if counter = 0 then
                          CANSAVE <= '1'; --DOMANDA:cansave, si pu� fare anche quando counter non � uguale a zero
                        end if;
                        if  CWP = SWP then --DOMANDA CWP = SWP, solo nel caso in cui sono entrambi a zero
                        --condizione per la quale � necessario fare FILL(?) dalla memoria.
                        --La condizione CANSAVE = '0' serve per non fare la FILL quando si fa call-ret-ret
                          FILL <= '1'; --va in input alla MMU
                          Restoring <= '1';
                          --DOMANDA, fill=riempire il registro?
                        --tempCWP <= CWP;
                        --SWP <= decreasePointerBuffer(SWP);
                        end if;
							end if;

							if CWP = 0 and counter /= 0 then
								counter <= counter - 1;
							end if;

						end if;	--fine condizione CANRESTORE = '1' o '0'
					end if; --fine condizione CALL='0' and RET='1'

        
        --here because we need to store or restore
        --STORE
				elsif Storing = '1' then --serve per salvare ad ogni clock gli 2*N registri

          
            --DOMANDA, store/restore di 2N registri o di 3N registri??
            --if firstStoring = '1' or (SWP mod (2*N)) /= 0  then
						--DATA_TO_MEM <= REGISTERS(SWP);
						--SWP <= (SWP + 1) mod TotalRegisters;	--aggiorna il valore di SWP e lo incrementa fino a 2*N 
						--firstStoring <= '0';
            if (counterReg<3*N) then
            DATA_TO_MEM <= REGISTERS(SWP+counterReg);
            counterReg <=counterReg+1;
            --se non erro, ad ogni ciclo di clock, il processo si rifa tutti gli if statement(ignorandoli per via di alcuni 
            --segnali bassi), e dovrebbe 
            --ritornare qui dentro, aggiornando il clock e il dato da mandare in MEMORIA
            else
						SPILL <= '0'; --quando ha salvato 2*N registri ababssa il segnale di SPILL e di Storing
						Storing <= '0';
            counterReg<=0;
						--firstStoring <= '1';
            SWP <=increaseSavedWindowPointer(SWP); --swp point to the next window to be saved
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

