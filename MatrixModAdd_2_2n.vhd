library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity MatrixModAdd_2_2n is
  generic(n : natural := 8);
  port(
    moduli_m1_A : in std_logic_vector(n-1 downto 0); -- first entry with n bits
    moduli_m1_B : in std_logic_vector(n-1 downto 0); -- second entry with n bits
    moduli_m1_Out : out std_logic_vector(2*n-1 downto 0) -- output exppected to have two times the number of bits
  );
end MatrixModAdd_2_2n;

architecture behavior of MatrixModAdd_2_2n is

  component CSA_EAC is
    generic (n : natural);
    port(		I0 : in STD_LOGIC_VECTOR((n-1) downto 0);
            I1 : in STD_LOGIC_VECTOR((n-1) downto 0);
            I2 : in STD_LOGIC_VECTOR((n-1) downto 0);
            S : out STD_LOGIC_VECTOR((n-1) downto 0);
            C : out STD_LOGIC_VECTOR((n-1) downto 0)
    );
  end component;

  component CPA_mod255 is
    generic(n : natural);
    port( s1 : in STD_LOGIC_VECTOR (n-1 downto 0);
          c1 : in STD_LOGIC_VECTOR (n-1 downto 0);
          f : out STD_LOGIC_VECTOR(n-1 downto 0)
    );
  end component;

  component Mux2_1 is
    generic(n : natural); -- quando for declarar o componente, generic map
    port(   A : in STD_LOGIC_VECTOR (n-1 downto 0);
            B : in STD_LOGIC_VECTOR (n-1 downto 0);
            Sel : in STD_LOGIC;
            S : out STD_LOGIC_VECTOR (n-1 downto 0));
    );
  end component;

  -- signals go down below
  signal A : std_logic_vector(n-1 downto 0);
  signal B, auxB : std_logic_vector(n-1 downto 0);
  signal C, auxC : std_logic_vector(n-1 downto 0);
  signal D, auxD : std_logic_vector(n-1 downto 0);
  signal E, auxE : std_logic_vector(n-1 downto 0);
  signal F, auxF : std_logic_vector(n-1 downto 0);
  signal G, auxG : std_logic_vector(n-1 downto 0);
  signal H, auxH : std_logic_vector(n-1 downto 0);
  signal mux_select : std_logic_vector(n-1 downto 0);
  signal sum0, sum1, sum2, sum3, sum4, sum5 : std_logic_vector(n-1 downto 0);
  signal carry0, carry1, carry2, carry3, carry4, carry5 : std_logic_vector(n-1 downto 0);

  begin

    mux_select <= moduli_m1_B;
    auxB <= moduli_m1_A(n-2 downto 0) & '0';
    auxC <= moduli_m1_A(n-3 downto 0) & "00";
    auxD <= moduli_m1_A(n-4 downto 0) & "000";
    auxE <= moduli_m1_A(n-5 downto 0) & "0000";
    auxF <= moduli_m1_A(n-6 downto 0) & "00000";
    auxG <= moduli_m1_A(n-7 downto 0) & "000000";
    auxH <= moduli_m1_A(0) & "0000000";

  U0: Mux2_1  generic map(n <= n)
              port map( "00000000", moduli_m1_A, moduli_m1_B(0), A);
  U1: Mux2_1  generic map( n <= n)
              port map( "00000000", auxB, moduli_m1_B(1), B );
  U2: Mux2_1  generic map( n <= n)
              port map( "00000000", auxC, moduli_m1_B(2), C );
  U3: Mux2_1  generic map( n <= n)
              port map( "00000000", auxD, moduli_m1_B(3), D );
  U4: Mux2_1  generic map( n <= n)
              port map( "00000000", auxE, moduli_m1_B(4), E );
  U5: Mux2_1  generic map( n <= n)
              port map( "00000000", auxF, moduli_m1_B(5), F );
  U6: Mux2_1  generic map( n <= n)
              port map( "00000000", auxG, moduli_m1_B(6), G );
  U7: Mux2_1  generic map( n <= n)
              port map( "00000000", auxH, moduli_m1_B(7), H );
  -- begin of CSA tree
  U8: CSA_EAC generic map(n <= n)
              port map(
                A, B, C, sum0, carry0
              );
  U9: CSA_EAC generic map(n <= n)
              port map(
                sum0, carry0, D, sum1, carry1
              );
  U10: CSA_EAC generic map(n <= n)
              port map(
                sum1, carry1, E, sum2, carry2
              );
  U11: CSA_EAC generic map(n <= n)
              port map(
                sum2, carry2, F, sum3, carry3
              );
  U12: CSA_EAC generic map(n <= n)
              port map(
                sum3, carry3, G, sum4, carry4
              );
  U13: CSA_EAC generic map(n <= n)
              port map(
                sum4, carry4, H, sum5, carry5
              );
  U14: CPA_mod255 generic map(n <= n)
                  port map(
                    sum5, carry5, moduli_m1_Out
                  );
end behavior;
