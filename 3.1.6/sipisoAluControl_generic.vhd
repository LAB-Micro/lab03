library IEEE;
use IEEE.std_logic_1164.all;

entity sipisoAluControl_generic is
generic (nbit : integer :=32);
port (
	clk, rst, strobeA, strobeB: in std_logic;
	shiftA, loadB, loadC, shiftC, startC: out std_logic
);
end	sipisoAluControl_generic;

--		EA <= oBuffer(0);
--		LDB <= oBuffer(1);
--		LDC <= oBuffer(2);
--		SHIFTC <= oBuffer(3);

architecture FSM_OPC of sipisoAluControl_generic is

	type TYPE_STATE is (S0, AF0, AF, AFend, WB, BS, BF, WA, AS0, AS, ASend, C0, C, Cend);
	signal CURRENT_STATE: TYPE_STATE := S0;
	signal NEXT_STATE: TYPE_STATE := S0;
	signal intO: std_logic_vector(4 downto 0) := "00000";
  signal current_counter, next_counter : integer :=0;

begin
 	
	P_OPC : process(clk, rst)		
	begin
		if rst='1' then
	       	CURRENT_STATE <= S0;
          current_counter <=0;
		elsif (clk ='1' and clk'EVENT) then 
			CURRENT_STATE <= NEXT_STATE;
      current_counter <=next_counter;
		end if;
	end process P_OPC;

	P_NEXT_STATE : process(CURRENT_STATE, current_counter, strobeA, strobeB)
	begin
--		NEXT_STATE <= CURRENT_STATE; --redundant
		case CURRENT_STATE is
			when S0 => 
				if strobeA = '1' and strobeB = '0' then
					NEXT_STATE <= AF0;
          next_counter <=0;
				elsif strobeA = '0' and strobeB = '1' then
					NEXT_STATE <= BF;
				else 
					NEXT_STATE <= S0;
				end if;
			when AF0 => 
				if strobeA = '1' and strobeB = '0' then
					NEXT_STATE <= AF0;
				else
					NEXT_STATE <= AF;	
            next_counter <=current_counter+1;
				end if;
			when AF => 
				if strobeA = '1' and strobeB = '0' then
					NEXT_STATE <= AF0;
            next_counter <=0;
				elsif (current_counter=nbit-1) then
					NEXT_STATE <= AFend;
          next_counter<=0;
        else 	
        NEXT_STATE <= AF;
        next_counter<=current_counter+1;
          
				end if;
	
			when AFend => 
				if strobeA = '1' and strobeB = '0' then
					NEXT_STATE <= AF0;
          next_counter<=0;
				elsif strobeA = '0' and strobeB = '1' then
					NEXT_STATE <= BS;
				else
					NEXT_STATE <= WB;
				end if;
			when WB => 
				if strobeA = '1' and strobeB = '0' then
					NEXT_STATE <= AF0;
          next_counter<=0;
				elsif strobeA = '0' and strobeB = '1' then
					NEXT_STATE <= BS;
				else
					NEXT_STATE <= WB;
				end if;
			when BS =>
				 if strobeA = '1' and strobeB = '0' then
					NEXT_STATE <= AS0;
          next_counter<=0;
				elsif strobeA = '0' and strobeB = '1' then
					NEXT_STATE <= BS;
				else
					NEXT_STATE <= C0;
          next_counter<=0;
				end if;
			when BF =>
				if strobeA = '1' and strobeB = '0' then
					NEXT_STATE <= AS0;
          next_counter<=0;
				elsif strobeA = '0' and strobeB = '1' then
					NEXT_STATE <= BF;
				else
					NEXT_STATE <= WA;
				end if;
			when WA =>
				if strobeA = '1' and strobeB = '0' then
					NEXT_STATE <= AS0;
          next_counter<=0;
				elsif strobeA = '0' and strobeB = '1' then
					NEXT_STATE <= BF;
				else
					NEXT_STATE <= WA;
				end if;
			when AS0 => 
				if strobeA = '1' and strobeB = '0' then
					NEXT_STATE <= AS0;
          next_counter<=0;
				else
					NEXT_STATE <= AS;
          next_counter<=current_counter+1;
				end if;
			when AS => 
				if strobeA = '1' and strobeB = '0' then
					NEXT_STATE <= AS0;
          next_counter<=0;
        elsif (current_counter=nbit-1) then
          NEXT_STATE <= ASend;
          next_counter<=0;
				else
					NEXT_STATE <= AS;
          next_counter<=current_counter+1;
				end if;
	
			when ASend =>
				if strobeA = '1' and strobeB = '0' then
					NEXT_STATE <= AS0;
          next_counter<=0;
				elsif strobeA = '0' and strobeB = '1' then
					NEXT_STATE <= BS;
				else
					NEXT_STATE <= C0;
          next_counter<=0;
				end if;
			when C0 => 
                NEXT_STATE <= C;
                next_counter<=0;
			when C => 
                if (current_counter=nbit-1) then
                NEXT_STATE <= Cend;
                next_counter <=0;
                else
                NEXT_STATE <= C;
                next_counter<=current_counter+1;
                end if;
			when Cend =>
				if strobeA = '1' and strobeB = '0' then
					NEXT_STATE <= AF0;
          next_counter<=0;
				elsif strobeA = '0' and strobeB = '1' then
					NEXT_STATE <= BF;
				else
					NEXT_STATE <= S0;
          next_counter<=0;
				end if;
		end case;	
	end process P_NEXT_STATE;

	
	P_OUTPUTS: process(CURRENT_STATE)
	begin
		--O <= '0';
		case CURRENT_STATE is
			when S0 | WA | WB | AFend | ASend => intO <= "00000";
			when BF | BS => intO <= "00010";
			when AF0 | AF | AS0 | AS => intO <= "00001";
			when C0 => intO <= "10100";
			when C | Cend => intO <= "01000";
		end case; 	
	end process P_OUTPUTS;

	shiftA <= intO(0);
	loadB <= intO(1);
	loadC <= intO(2);
	shiftC <= intO(3);
	startC <= intO(4);

end FSM_OPC;
 
configuration CFG_SIPISO_ALU_CONTROL_generic_BEH of SIPISOALUCONTROL_generic is
  for FSM_OPC
  end for;
end configuration;