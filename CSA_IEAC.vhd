library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity CSA_IEAC is
	generic (n : natural);
  	 port(		I0 : in STD_LOGIC_VECTOR((n-1) downto 0);
			I1 : in STD_LOGIC_VECTOR((n-1) downto 0);
			I2 : in STD_LOGIC_VECTOR((n-1) downto 0);
			S : out STD_LOGIC_VECTOR((n-1) downto 0);
			C : out STD_LOGIC_VECTOR((n-1) downto 0));
end CSA_IEAC;
  
architecture Structural of CSA_IEAC is
 component fulladder is
 	 port(A : in STD_LOGIC;
			B : in STD_LOGIC;
			Cin : in STD_LOGIC;
			S : out STD_LOGIC;
			Cout : out STD_LOGIC);
 end component;
 
signal c_intermed : STD_LOGIC_VECTOR(n downto 0);

begin
  		
CSA_1: for j in 0 to n-1 generate
  row_1:	fulladder port map( A => I0(j),B => I1(j), Cin => I2(j), S =>S(j) , Cout => c_intermed(j+1) );
  end generate CSA_1;
  	
C(n-1 downto 1) <= c_intermed(n-1 downto 1);	
C(0) <= not(c_intermed(n));
  		
end Structural;