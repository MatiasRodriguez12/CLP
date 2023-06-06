library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity mulPF_vio is
	port (
		clk_i : in std_logic
	);
end;

architecture mulPF_vio_arq of mulPF_vio is

	component mulPF is
		generic (
			Nb     : natural := 32;
			Nb_exp : natural := 8
		);
		port (
			a_i   : in std_logic_vector(Nb - 1 downto 0);
			b_i   : in std_logic_vector(Nb - 1 downto 0);
			mul_o : out std_logic_vector(Nb - 1 downto 0)
		);
	end component;

	component vio_0
		port (
			clk        : in std_logic;
			probe_in0  : in std_logic_vector(31 downto 0);
			probe_out0 : out std_logic_vector(31 downto 0);
			probe_out1 : out std_logic_vector(31 downto 0)
		);
	end component;

	signal a_probe   : std_logic_vector(31 downto 0);
	signal b_probe   : std_logic_vector(31 downto 0);
	signal mul_probe : std_logic_vector(31 downto 0);

begin

	mul_pf_inst1 : mulPF
	generic map(
		Nb     => 32,
		Nb_exp => 8
	)
	port map(
		a_i   => a_probe,
		b_i   => b_probe,
		mul_o => mul_probe
	);

	vio_inst2 : vio_0
	port map(
		clk        => clk_i,
		probe_in0  => mul_probe,
		probe_out0 => a_probe,
		probe_out1 => b_probe
	);

end;