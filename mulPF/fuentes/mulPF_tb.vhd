library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity mulPF_tb is
end;

architecture mulPF_tb_arq of mulPF_tb is
	
	constant	Nb_tb		: natural:= 33;
	constant	Nb_exp_tb	: natural:= 8;
	constant	Nb_frac_tb	: natural:= Nb_tb-Nb_exp_tb-1;
	constant	Sesgo_tb	: natural:= 2**(Nb_exp_tb-1)-1;
	
	-- Declaracion de senales de prueba
	signal a_tb		: std_logic_vector(Nb_tb-1 downto 0);
	signal b_tb		: std_logic_vector(Nb_tb-1 downto 0);
	signal mul_tb	: std_logic_vector(Nb_tb-1 downto 0);
	signal a_exp_tb	: natural:= 0;
	signal b_exp_tb	: natural:= 0;
	signal clk		: std_logic:='0';
	

begin
	clk <= not clk after 100 ns;
	-- Para 32 bits de longitud
	--a_tb<= '0' & std_logic_vector(to_unsigned(Sesgo_tb+a_exp_tb,Nb_exp_tb)) & std_logic_vector(to_unsigned(0,Nb_frac_tb)), 
	--		X"3FC00000" after 100 ns,
	--		X"40DA0000" after 300 ns,
	--		X"BFC00000" after 500 ns,
	--		X"C0DA0000" after 700 ns;

	--b_tb<= '0' & std_logic_vector(to_unsigned(Sesgo_tb+b_exp_tb,Nb_exp_tb)) & std_logic_vector(to_unsigned(0,Nb_frac_tb)), 
	--		X"41A18000" after 200 ns,
	--		X"BEB00000" after 400 ns,
	--		X"3F500000" after 600 ns,
	--		X"C1A18000" after 800 ns;

	-- Para 33 bits de longitud
	a_tb<= '0' & std_logic_vector(to_unsigned(Sesgo_tb+a_exp_tb,Nb_exp_tb)) & std_logic_vector(to_unsigned(0,Nb_frac_tb)), 
			'0'&X"7F800000" after 100 ns,
			'0'&X"81B40000" after 300 ns,
			'1'&X"7F800000" after 500 ns,
			'1'&X"81B40000" after 700 ns;

	b_tb<= '0' & std_logic_vector(to_unsigned(Sesgo_tb+b_exp_tb,Nb_exp_tb)) & std_logic_vector(to_unsigned(0,Nb_frac_tb)), 
			'0'&X"83430000" after 200 ns,
			'1'&X"7D600000" after 400 ns,
			'0'&X"7EA00000" after 600 ns,
			'1'&X"83430000" after 800 ns;

	DUT: entity work.mulPF
		generic map(
			Nb 		=> Nb_tb,		
			Nb_exp 	=> Nb_exp_tb
		)
		port map(
			a_i	 	=> a_tb, 
			b_i	 	=> b_tb,
			mul_o 	=> mul_tb
		);
	
end;