library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pwm is
  Port (
        clock: in std_logic;
        duty: in integer range 0 to 100 := 50;
        sig: out std_logic := '0'
  );
end pwm;

architecture Behavioral of pwm is
    signal count: integer range 0 to 101 := 0;
    signal mult_count: integer range 0 to 1001 := 0;
begin
    process(clock)
    begin
        if (rising_edge(clock)) then
            mult_count <= mult_count + 1;
            if (mult_count >= 1000) then
                mult_count <= 0;
                count <= count + 1;
                if (count >= 100) then
                    count <= 0;
                end if;
                if (count < duty) then
                    sig <= '1';
                else
                    sig <= '0';
                end if;
            end if;
            
        end if;
    end process;
end Behavioral;
