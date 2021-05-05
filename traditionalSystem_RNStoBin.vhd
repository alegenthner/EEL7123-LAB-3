library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity traditionalSystem_RNStoBin is
	generic (n : natural := 4);
	port(
		SW    : in STD_LOGIC_VECTOR(17 downto 0);
		LEDR : out STD_LOGIC_VECTOR(17 downto 0)
	);
end traditionalSystem_RNStoBin;

architecture Structural of traditionalSystem_RNStoBin is

  component CSA_EAC is
         generic (n : natural := 8);
  	 port(I0 : in STD_LOGIC_VECTOR((n-1) downto 0);
	      I1 : in STD_LOGIC_VECTOR((n-1) downto 0);
	      I2 : in STD_LOGIC_VECTOR((n-1) downto 0);
	      S : out STD_LOGIC_VECTOR((n-1) downto 0);
	      C : out STD_LOGIC_VECTOR((n-1) downto 0));
  end component;

  component CPA_mod255 is
  	generic (n : natural := 8);
  	 port(s1 : in STD_LOGIC_VECTOR((n-1) downto 0);
	      c1 : in STD_LOGIC_VECTOR((n-1) downto 0);
	      f : out STD_LOGIC_VECTOR((n-1) downto 0));
  end component;

signal zeros : std_logic_vector(n-2 downto 0);
signal A, B, C, D: std_logic_vector(2*n-1 downto 0);
signal sum0_2n_m1 , carry0_2n_m1 : std_logic_vector(2*n-1 downto 0);
signal sum1_2n_m1 , carry1_2n_m1 : std_logic_vector(2*n-1 downto 0);
signal ones : std_logic_vector(2 downto 0);

begin

  ones <= (others => '1');
  zeros <= (others => '0');

  A(2*n-1 downto 0) <= not(SW(2*n-1 downto 0));
  B(2*n-1 downto 0) <= SW(8) & SW(11 downto 8) & SW(11 downto 9);
  C(2*n-1 downto 0) <= SW(12) & zeros & SW(16 downto 13);
  D(2*n-1 downto 0) <= not(SW(16 downto 12)) & ones;

  comp0_2n_m1: CSA_EAC generic map	(  n => 2*n)
  	                   port map (I0 => A, I1 => B, I2 => C, S => sum0_2n_m1, C => carry0_2n_m1); -- A fazer pel@ alun@

  comp1_2n_m1: CSA_EAC generic map	(  n => 2*n)
  	                   port map (I0 => sum0_2n_m1, I1 => carry0_2n_m1, I2 => D, S => sum1_2n_m1, C => carry1_2n_m1); -- A fazer pel@ alun@

  add_2n_m1: CPA_mod255 generic map	(  n => 2*n)
                           port map(s1 => sum1_2n_m1, c1 => carry1_2n_m1, f => LEDR(15 downto 8)); -- A fazer pel@ alun@

	LEDR(17 downto 16) <= "00";
	LEDR(7 downto 0) <= SW(7 downto 0);
  end Structural;
