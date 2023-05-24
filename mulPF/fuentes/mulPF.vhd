library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;


entity mulPF is
	generic(
		Nb:			natural:= 32;
		Sesgo: 		natural:= 127;
		Nb_exp:		natural:= 8;
		Nb_frac: 	natural:= 23
	);
	port(
		a_i: 	in std_logic_vector(Nb-1 downto 0);
		b_i:	in std_logic_vector(Nb-1 downto 0);
		mul_o: 	out std_logic_vector(Nb-1 downto 0)
	);
end;

architecture mulPF_arq of mulPF is
	signal a_exp,b_exp,mul_exp		: std_logic_vector(Nb_exp - 1 downto 0);
	signal a_frac,b_frac,mul_frac	: std_logic_vector(Nb_frac downto 0);
	signal a_sig,b_sig,mul_sig		: std_logic;

	signal sum_to_sum,sum_out		: std_logic_vector(Nb_exp downto 0);
	signal sesgo_to_sum				: std_logic_vector(Nb_exp-1 downto 0);
	signal mul_out					: std_logic_vector(2*Nb_frac+1 downto 0);

begin

	a_sig  <= a_i(Nb-1);
	b_sig  <= b_i(Nb-1);
	a_exp  <= a_i(Nb-2 downto Nb_frac);
	b_exp  <= b_i(Nb-2 downto Nb_frac);
	a_frac <= '1' & a_i(Nb_frac-1 downto 0);
	b_frac <= '1' & b_i(Nb_frac-1 downto 0);

	sesgo_to_sum <= std_logic_vector(to_unsigned(Sesgo,Nb_exp));

	mul_sig <=  a_sig xor b_sig;


	sumNb_inst1: entity work.sumresNb
		generic map(
			N => Nb_exp
		)
		port map(
			a_i  => a_exp,
			b_i  => b_exp,
			ci_i => '0',
			s_o  => sum_to_sum(Nb_exp-1 downto 0),
			co_o => sum_to_sum(Nb_exp)
		);

	sumNb_inst2: entity work.sumresNb
		generic map(
			N => Nb_exp
		)
		port map(
			a_i  => sum_to_sum(Nb_exp-1 downto 0),
			b_i  => sesgo_to_sum,
			ci_i => '1',
			s_o  => sum_out(Nb_exp-1 downto 0),
			co_o => sum_out(Nb_exp)
		);

	sumNb_inst: entity work.mulNb
			generic map(
				N => Nb_frac+1
			)
			port map(
				a_i  => a_frac,
				b_i  => b_frac,
				mul_o => mul_out
			);

	mul_o <= mul_sig & sum_out(Nb_exp-1 downto 0) & mul_out(2*Nb_frac downto Nb_frac+1);

end;