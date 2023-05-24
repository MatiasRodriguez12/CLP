library IEEE;
use IEEE.std_logic_1164.all;

entity mulPF_tb is
end;

architecture mulPF_tb_arq of mulPF_tb is
	
	constant	Nb_tb:			natural:= 32;
	constant	Sesgo_tb: 		natural:= 127;
	constant	Nb_exp_tb:		natural:= 8;
	constant	Nb_frac_tb: 	natural:= 23;
	
	-- Declaracion de senales de prueba
	signal a_tb: std_logic_vector(Nb_tb-1 downto 0) := (Nb_tb-1 downto 0 => '0');
	signal b_tb: std_logic_vector(Nb_tb-1 downto 0) := (Nb_tb-1 downto 0 => '0');
	signal mul_tb: std_logic_vector(Nb_tb-1 downto 0);
	

begin
	--b_tb <=  "00111101" after 100 ns, "10111101" after 300 ns, "10000011" after 500 ns, "11111111" after 700 ns;
	--a_tb <=  "01100101" after 200 ns, "00100001" after 400 ns, "10101011" after 600 ns, "11111111" after 900 ns;
	-- 0000 0000 0000 0000 0000 0000 0000 0000
	a_tb <= "01000000110000000000000000000000" after 100 ns;
	b_tb <= "01000001110100000000000000000000" after 200 ns;

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