library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity mulPF is
	generic (
		Nb     : natural := 32;
		Nb_exp : natural := 8
	);
	port (
		a_i   : in std_logic_vector(Nb - 1 downto 0);
		b_i   : in std_logic_vector(Nb - 1 downto 0);
		mul_o : out std_logic_vector(Nb - 1 downto 0)
	);
end;

architecture mulPF_arq of mulPF is

	constant Nb_frac             : natural := Nb - Nb_exp - 1;
	constant Sesgo               : natural := 2 ** (Nb_exp - 1) - 1;

	signal a_exp, b_exp, mul_exp : std_logic_vector(Nb_exp - 1 downto 0);
	signal a_mag, b_mag          : std_logic_vector(Nb_frac downto 0);
	signal a_sig, b_sig, mul_sig : std_logic;

	signal sum_to_sum, sum_out   : std_logic_vector(Nb_exp downto 0);
	signal sesgo_to_sum          : std_logic_vector(Nb_exp - 1 downto 0);
	signal mul_out               : std_logic_vector(2 * Nb_frac + 1 downto 0);
	signal mul_red, mul_frac     : std_logic_vector(Nb_frac downto 0);
	signal sum_red               : std_logic_vector(Nb_frac - 1 downto 0);

begin

	a_sig        <= a_i(Nb - 1);
	b_sig        <= b_i(Nb - 1);
	a_exp        <= a_i(Nb - 2 downto Nb_frac);
	b_exp        <= b_i(Nb - 2 downto Nb_frac);
	a_mag        <= '1' & a_i(Nb_frac - 1 downto 0);
	b_mag        <= '1' & b_i(Nb_frac - 1 downto 0);

	sesgo_to_sum <= std_logic_vector(to_unsigned(Sesgo, Nb_exp)) when mul_out(2 * Nb_frac + 1) = '0' else std_logic_vector(to_unsigned(Sesgo - 1, Nb_exp));

	mul_red      <= mul_out(2 * Nb_frac - 1 downto Nb_frac - 1) when mul_out(2 * Nb_frac + 1) = '0' else mul_out(2 * Nb_frac downto Nb_frac);
	sum_red      <= (Nb_frac - 2 downto 0 => '0') & mul_red(0);

	mul_sig      <= a_sig xor b_sig;
	mul_exp      <= sum_out(Nb_exp - 1 downto 0);

	-- Sumo los exponentes de ambas entradas
	sum_exp_inst1 : entity work.sumresNb
		generic map(
			N => Nb_exp
		)
		port map(
			a_i  => a_exp,
			b_i  => b_exp,
			ci_i => '0',
			s_o  => sum_to_sum(Nb_exp - 1 downto 0),
			co_o => sum_to_sum(Nb_exp)
		);

	-- Resto sesgo (SESGO si no es necesaria la alineación de coma, SESGO-1 si es necesaria la alineación de coma)
	res_sesgo_inst2 : entity work.sumresNb
		generic map(
			N => Nb_exp
		)
		port map(
			a_i  => sum_to_sum(Nb_exp - 1 downto 0),
			b_i  => sesgo_to_sum,
			ci_i => '1',
			s_o  => sum_out(Nb_exp - 1 downto 0),
			co_o => sum_out(Nb_exp)
		);

	-- Multiplico las magnitudes de ambas entradas (tratándolos como números enteros sin signo)
	mul_magnitud_inst3 : entity work.mulNb
		generic map(
			N => Nb_frac + 1
		)
		port map(
			a_i   => a_mag,
			b_i   => b_mag,
			mul_o => mul_out
		);

	-- Realizo un redondeo de la parte fraccionaria de la magnitud
	redondeo_inst4 : entity work.sumresNb
		generic map(
			N => Nb_frac
		)
		port map(
			a_i  => mul_red(Nb_frac downto 1),
			b_i  => sum_red,
			ci_i => '0',
			s_o  => mul_frac(Nb_frac - 1 downto 0),
			co_o => mul_frac(Nb_frac)
		);

	mul_o <= mul_sig & mul_exp & mul_frac(Nb_frac - 1 downto 0);

end;