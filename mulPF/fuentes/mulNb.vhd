library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity mulNb is
	generic (
		N : natural := 4
	);
	port (
		a_i   : in std_logic_vector(N - 1 downto 0);
		b_i   : in std_logic_vector(N - 1 downto 0);
		mul_o : out std_logic_vector(2 * N - 1 downto 0)
	);
end;

architecture mulNb_arq of mulNb is

	type matriz is array (0 to N - 1) of std_logic_vector(N - 1 downto 0);
	type matriz_p is array (0 to N) of std_logic_vector(N downto 0);
	signal sum_b_in   : matriz;
	signal p_auxiliar : matriz_p := (others => (others => '0'));
	signal mul_aux    : std_logic_vector(2 * N - 1 downto 0);

begin
	p_auxiliar(0) <= (others => '0');

	sum_b : for i in 0 to N - 1 generate
		sum_b_in(i) <= b_i when a_i(i) = '1' else (others => '0');
	end generate;

	p_aux_fin : for i in 1 to N - 1 generate
		mul_aux(i - 1) <= p_auxiliar(i)(0);
	end generate;

	sumresNb_gen : for i in 1 to N generate
		sumNb_inst : entity work.sumresNb
			generic map(
				N => N
			)
			port map(
				a_i  => p_auxiliar(i - 1)(N downto 1),
				b_i  => sum_b_in(i - 1),
				ci_i => '0',
				s_o  => p_auxiliar(i)(N - 1 downto 0),
				co_o => p_auxiliar(i)(N)
			);
	end generate;

	mul_aux(2 * N - 1 downto N - 1) <= p_auxiliar(N);
	mul_o                           <= mul_aux;

end;