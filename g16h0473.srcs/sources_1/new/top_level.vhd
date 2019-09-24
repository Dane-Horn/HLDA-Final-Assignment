
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_level is
    Port ( 
        clock: in std_logic;
        fnum: in STD_LOGIC_VECTOR(7 downto 0);
        snum: in STD_LOGIC_VECTOR(7 downto 0);
        res: out STD_LOGIC_VECTOR(7 downto 0);
        fin_carry: out STD_LOGIC;
        seg: out std_logic_vector (0 to 6);
        an: out std_logic_vector (3 downto 0)
    );
end top_level;

architecture Behavioral of top_level is
    component ripple_adder is
        Port (
            fnum: in STD_LOGIC_VECTOR(7 downto 0) := "00000000";
            snum: in STD_LOGIC_VECTOR(7 downto 0) := "00000000";
            result: out STD_LOGIC_VECTOR(7 downto 0);
            final_carry: out STD_LOGIC
        );
    end component;
    component negater is
        Port (
            num: in std_logic_vector (7 downto 0);
            negated: out std_logic_vector (7 downto 0)
        );
    end component;
    component hex_display is
      Port (
        clock: in std_logic;
        num: in std_logic_vector (7 downto 0);
        seg: out std_logic_vector (0 to 6);
        an: out std_logic_vector (3 downto 0)
      );
    end component;
    signal neg_snum: std_logic_vector (7 downto 0) := "00000000";
    signal sub_result: std_logic_vector (7 downto 0) := "00000000";
begin
    hex_d: hex_display port map(clock => clock, num => sub_result, seg => seg, an => an);
    neg: negater port map(num => snum, negated => neg_snum);
    ripple: ripple_adder port map(fnum => fnum, snum => neg_snum, result => sub_result, final_carry => fin_carry);
    res <= sub_result;
end Behavioral;
