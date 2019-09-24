library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ripple_adder is
  Port (
        fnum: in STD_LOGIC_VECTOR(7 downto 0) := "00000000";
        snum: in STD_LOGIC_VECTOR(7 downto 0) := "00000000";
        result: out STD_LOGIC_VECTOR(7 downto 0) := "00000000";
        final_carry: out STD_LOGIC --will flag if an underflow occurred
  );
end ripple_adder;

architecture Behavioral of ripple_adder is

    component full_adder is
        port (
            a, b, cin: in std_logic;
            s, cout: out std_logic
        );
    end component;
    
    signal c: std_logic_vector(8 downto 0) := "000000000";

begin
    adder0: full_adder port map(a => fnum(0), b => snum(0), cin => c(0), s => result(0), cout => c(1));
    adder1: full_adder port map(a => fnum(1), b => snum(1), cin => c(1), s => result(1), cout => c(2));
    adder2: full_adder port map(a => fnum(2), b => snum(2), cin => c(2), s => result(2), cout => c(3));
    adder3: full_adder port map(a => fnum(3), b => snum(3), cin => c(3), s => result(3), cout => c(4));
    adder4: full_adder port map(a => fnum(4), b => snum(4), cin => c(4), s => result(4), cout => c(5));
    adder5: full_adder port map(a => fnum(5), b => snum(5), cin => c(5), s => result(5), cout => c(6));
    adder6: full_adder port map(a => fnum(6), b => snum(6), cin => c(6), s => result(6), cout => c(7));
    adder7: full_adder port map(a => fnum(7), b => snum(7), cin => c(7), s => result(7), cout => c(8));
    c(0) <= '1'; 
    final_carry <= not c(8); --9th cout will flag underflow
end Behavioral;
