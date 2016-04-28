library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity SIPISOALU_generic is 
generic (nbit : integer := 32);
	Port (	CLK	:	In	std_logic;
		RESET	:  	In      std_logic;
		STARTA	:  	In 	std_logic;
		A	:	In	std_logic;
		LOADB	:	In 	std_logic;
		B	:	In	std_logic_vector(nbit-1 downto 0);
		STARTC	:	Out	std_logic;
		C	:	Out	std_logic);
end SIPISOALU_generic; 



architecture A of SIPISOALU_generic is

	signal SIPO		 : std_logic_vector(nbit-2 downto 0) := (others => '0');
	signal SIPOA, PIPO, PISO : std_logic_vector(nbit-1 downto 0) := (others => '0');
	signal SUM		 : std_logic_vector(nbit downto 0) := (others => '0');
	signal EA, LDB		 : std_logic := '0';
	signal LoaDC, SHIFTC	 : std_logic := '0';
	signal count, next_count : integer range 0 to nbit-1 := 0;	


	-- FSM component declaration
	component sipisoAluControl_generic
  generic (nbit : integer := 32);
	port (
		clk, rst, strobeA, strobeB: in std_logic;
		shiftA, loadB, loadC, shiftC, startC: out std_logic
	);
	end component;

	-- begin architecture
	begin


		SIPO_nBIT_minus1_A: process(CLK, RESET)
		begin
			if(RESET='1')
				then SIPO <= (others => '0');
			elsif (CLK'event and CLK='1')
				then
					if(EA='1')
						then SIPO <= SIPO(nbit-3 downto 0) & A;
					end if;
			end if;
		end process;

		SIPOA <= SIPO & a;


		PIPO_nBIT_B: process(CLK, RESET)
		begin
			if(RESET='1')
				then PIPO <= (others => '0');
			elsif (CLK'event and CLK='1')
				then
					if(LDB='1')
						then PIPO <= B;
					end if;
			end if;
		end process;


		PISO_nBIT_C: process(CLK, RESET)
		begin
			if(RESET='1')
				then PISO <= (others => '0');
			elsif (CLK'event and CLK='1')
				then
					if(LoaDC='1')
						then PISO <= SUM(nbit-1 downto 0);
					elsif(SHIFTC='1')
						then PISO <= '0' & PISO(nbit-1 downto 1);
					end if;
			end if;
		end process;


		C <= PISO(0);

		SUM <= ('0' & PIPO) + ('0' & SIPOA);


	-- FSM instance port map
	control: sipisoAluControl_generic
  generic map(nbit)
	port map(
		clk => CLK,
		rst => RESET,
		strobeA => STARTA,
		strobeB => LOADB,
		shiftA => EA,
		loadB => LDB,
		loadC => LoaDC,
		shiftC => SHIFTC,
		startC => STARTC
	);

end A;

configuration CFG_SIPISO_ALU_generic_BEH of SIPISOALU_generic is
  for A
	for all : sipisoAluControl_generic
	use configuration WORK.CFG_SIPISO_ALU_CONTROL_generic_BEH;
	end for;
  end for;
end configuration;
