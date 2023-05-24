library IEEE;
use IEEE.std_logic_1164.all;

entity sumresNb is
	generic(
		N: natural := 4
	);
	port(
		a_i: in std_logic_vector(N-1 downto 0);
		b_i: in std_logic_vector(N-1 downto 0);
		ci_i: in std_logic;
		s_o: out std_logic_vector(N-1 downto 0);
		co_o: out std_logic
	);
end;

architecture sumresNb_arq of sumresNb is
	signal aux: std_logic_vector(N downto 0);
	signal b_in: std_logic_vector(N-1 downto 0);
begin

	aux(0) <= ci_i;
	co_o <= aux(N);

	sum_b: for i in 0 to N-1 generate
		b_in(i)  <= b_i(i) xor ci_i;
	end generate;
	
	sumNb_gen: for i in 0 to N-1 generate
		sum1b_inst: entity work.sum1b
			port map(
				a_i  => a_i(i),
				b_i  => b_in(i),
				ci_i => aux(i),
				s_o  => s_o(i),
				co_o => aux(i+1)
			);
	end generate;

end;