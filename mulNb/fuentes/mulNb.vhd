library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;


entity mulNb is
	generic(
		N: natural := 4
	);
	port(
		a_i: 	in std_logic_vector(N-1 downto 0);
		b_i:	in std_logic_vector(N-1 downto 0);
		mul_o: 	out std_logic_vector(2*N-1 downto 0)
	);
end;

architecture mulNb_arq of mulNb is
	
	type matriz is array (0 to N-1) of std_logic_vector(N-1 downto 0);
	type matriz_p is array (0 to N) of std_logic_vector(2*N downto 0);
	signal sum_b_in: matriz;
	signal p_auxiliar: matriz_p:=(others => (others => '0'));
	signal p_init: std_logic_vector(2*N downto 0):=(others=>'0');
	
begin
	p_auxiliar(0)<=p_init; 
	
	sum_b: for i in 0 to N-1 generate
		sum_b_in(i)  <= b_i when a_i(i)='1' else (others=>'0') ;
	end generate;
	p_aux: for i in 1 to N-1 generate
		p_auxiliar(i)(N-i-1 downto 0)  <=  a_i(N-1 downto i) ;
	end generate;	
	p_aux_fin: for i in 1 to N-1 generate
		p_auxiliar(N)(i-1)  <=  p_auxiliar(i)(N-1) ;
	end generate;
	sumNb_gen: for i in 1 to N generate
		sumNb_inst: entity work.sumNb
			generic map(
				N => N
			)
			port map(
				a_i  => p_auxiliar(i-1)(2*N-1 downto N),
				b_i  => sum_b_in(i-1),
				ci_i => '0',
				s_o  => p_auxiliar(i)(2*N-2 downto N-1),
				co_o => p_auxiliar(i)(2*N-1)
			);
	end generate;
	mul_o <= p_auxiliar(N)(2*N-1 downto 0);
end;