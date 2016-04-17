library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity windowed_reg is
generic (
          M : integer :=4; --number global registere
          N : integer :=4; --number of registers in each of the IN/OUT/LOCAL window
          npower_for_N : integer :=2; --exponent 2^npower= N
          nbit : integer := 8; --width of each register
          F : integer :=4 --number of window
          );
port(

        CLK: 		  IN std_logic;
        RESET: 	  IN std_logic; --reset all the RF
        ENABLE: 	IN std_logic;
        RD1: 		  IN std_logic;
        RD2:  		IN std_logic;
        WR: 	  	IN std_logic;
        ADD_WR: 	IN std_logic_vector(npower_for_N-1 downto 0);
        ADD_RD1: 	IN std_logic_vector(npower_for_N-1 downto 0);
        ADD_RD2: 	IN std_logic_vector(npower_for_N-1 downto 0);
        DATAIN: 	IN std_logic_vector(nbit-1 downto 0);
        OUT1: 		OUT std_logic_vector(nbit-1 downto 0);
        OUT2: 		OUT std_logic_vector(nbit-1 downto 0);

        --subroutine management
        subcall : in std_logic;
        ret     : in std_logic;
                
        --signal to/from memory
        bus_from_mem : in std_logic; -- bus input/output per l'accesso da/a Memoria
        bus_to_mem : out std_logic;
        data_from_mem : in std_logic_vector( N*3-1 downto 0);
        data_to_mem : out std_logic_vector( N*3-1 downto 0)--data to store/restore to/from memory
        --the width is N*3, register IN, OUT, LOCAL, don't save the global register???????????????????
);
end windowed_reg;

architecture Behavioral of windowed_reg is

--internal register
signal SWP, CWP : integer :=0; 
signal CANSAVE, CANRESTORE : std_logic_vector(63 downto 0);

--signal for number of round completed --giri completi
signal round : integer :=0;

--signal for I/O for the RF
signal call_s, ret_s, fill_s, spill_s : std_logic;



begin

--swp <= (others=>'0');
--cwp <= (others =>'0');


--SALVARE IN MEMORIA WINDOW 0 (swp =0)
         --codice


call_process : process (subcall)
begin

        --aggiorno cwp e gestisco quando cwp punta l'ultimo window per la PRIMA
        if ((cwp >= 2*N*(f-1)) and swp = 0) then --ha finito i windows liberi per la PRIMA volta, si trova nell'ultimo window
        round <= round +1; --primo giro completato
        cwp <= 0; --ritorna a window 0
        swp <= swp + 2*N;
         --SALVARE IN MEMORIA WINDOW 1 (swp=2N, puntatore window 1, giro=1)
         --codice da scrivere
         ---
         
        
        --aggiorno cwp e gestisco quando cwp punta l'ultimo window per l'n-esima volta,
         elsif ((cwp >= 2*N*(f-1)) and swp > 0) then --ha finito i windows liberi per l'n-esima volta,
         round <= round +1; --n-esimo giro completato
         cwp <= 0; --ritorna a window 0
          swp <= swp + 2*N;
          --SALVARE IN MEMORIA WINDOW 1 (swp=2N, puntatore window 1, giro =n....)
         --codice da scrivere
         ---
          
          
          
          --non ho finito il giro per cwp [(cwp < 2*N*(f-1)], ci sono altre finestre libere [cwp non punta all'ultimo e round =0], non devo salvare niente 
          elsif ((cwp < 2*N*(f-1) and round=0)) then --round=0, implica swp=0, nessun window da salvare
         cwp <= cwp + 2*N; --se prima call effettuata, lo chiama da window 0 e va direttamente a window 1
         
         
         
         elsif ((cwp < 2*N*(f-1)) and round > 0) then --ho finito il primo giro, tutti i window occupati
         --e deve ogni volta salvare il prox window su memoria 
         --perchè in caso di call il prox window verrà sovrascritto
                 if (swp > 2*N*(f-1)) then --ha già salvato tutti i window e deve ritornare a zero.
                    swp <= 0; 
                    --SALVARE IN MEMORIA WINDOW 1 del round n...
                    --codice da scrivere
                    ---
                 
                 else --
                 swp <=swp + 2*N;
                 end if;
         end if;
end process;




call_ret : process (ret)
begin
end process;




end Behavioral;

