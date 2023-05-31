library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity mulPF_vio is
	port (
		clk_i   : in std_logic
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

  COMPONENT vio_0
  PORT (
    clk : IN STD_LOGIC;
    probe_in0 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    probe_out0 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    probe_out1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;

	signal a_probe : std_logic_vector(31 downto 0);
	signal b_probe : std_logic_vector(31 downto 0);
	signal mul_probe : std_logic_vector(31 downto 0);

begin

	mul_pf : mulPF
		generic map(
			Nb => 32,
			Nb_exp =>8
		)
		port map(
			a_i   => a_probe,
			b_i   => b_probe,
			mul_o => mul_probe
		);

	your_instance_name : vio_0
  		PORT MAP (
    	clk => clk_i,
    	probe_in0 => mul_probe,
    	probe_out0 => a_probe,
    	probe_out1 => b_probe
  	);

end;