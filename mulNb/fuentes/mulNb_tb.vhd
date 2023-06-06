library IEEE;
use IEEE.std_logic_1164.all;

entity mulNb_tb is
end;

architecture mulNb_tb_arq of mulNb_tb is

	constant N_tb : natural                             := 8;

	-- Declaracion de senales de prueba
	signal a_tb   : std_logic_vector(N_tb - 1 downto 0) := (N_tb - 1 downto 0 => '0');
	signal b_tb   : std_logic_vector(N_tb - 1 downto 0) := (N_tb - 1 downto 0 => '0');
	signal mul_tb : std_logic_vector(2 * N_tb - 1 downto 0);
	signal clk    : std_logic := '0';

begin
	clk  <= not clk after 100 ns;
	b_tb <= "00111101" after 100 ns, "10111101" after 300 ns, "10000011" after 500 ns, "11111111" after 700 ns;
	a_tb <= "01100101" after 200 ns, "00100001" after 400 ns, "10101011" after 600 ns, "11111111" after 900 ns;

	DUT : entity work.mulNb
		generic map(
			N => N_tb
		)
		port map(
			a_i   => a_tb,
			b_i   => b_tb,
			mul_o => mul_tb
		);

end;