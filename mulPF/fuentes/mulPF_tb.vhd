library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity mulPF_tb is
end;

architecture mulPF_tb_arq of mulPF_tb is
	
	constant	Nb_tb:			natural:= 32;
	constant	Sesgo_tb: 		natural:= 127;
	constant	Nb_exp_tb:		natural:= 8;
	constant	Nb_frac_tb: 	natural:= 23;
	
	-- Declaracion de senales de prueba
	signal a_tb: std_logic_vector(Nb_tb-1 downto 0) := "01000000000000000000000000000000";
	signal b_tb: std_logic_vector(Nb_tb-1 downto 0) := "01000000000000000000000000000000";
	signal mul_tb: std_logic_vector(Nb_tb-1 downto 0);
	signal a_exp_tb: natural:= 0;
	signal b_exp_tb: natural:= 0;
	

begin

	a_tb<= '0' & std_logic_vector(to_unsigned(Sesgo_tb+a_exp_tb,Nb_exp_tb)) & std_logic_vector(to_unsigned(0,Nb_frac_tb)), 
			X"3FC00000" after 100 ns,
			X"40DA0000" after 300 ns,
			X"BFC00000" after 500 ns,
			X"C0DA0000" after 700 ns;

	b_tb<= '0' & std_logic_vector(to_unsigned(Sesgo_tb+b_exp_tb,Nb_exp_tb)) & std_logic_vector(to_unsigned(0,Nb_frac_tb)), 
			X"41A18000" after 200 ns,
			X"BEB00000" after 400 ns,
			X"3F500000" after 600 ns,
			X"C1A18000" after 800 ns;

	DUT: entity work.mulPF
		generic map(
			Nb 		=> Nb_tb,		
			Sesgo	=> Sesgo_tb,
			Nb_exp 	=> Nb_exp_tb,
			Nb_frac => Nb_frac_tb
		)
		port map(
			a_i	 	=> a_tb, 
			b_i	 	=> b_tb,
			mul_o 	=> mul_tb
		);
	
end;