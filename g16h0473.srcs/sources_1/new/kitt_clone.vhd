library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity kitt_clone is
  Port (
    btnC : in std_logic;
    clock : in std_logic;
    lights: out std_logic_vector(15 downto 0)
  );
end kitt_clone;

architecture Behavioral of kitt_clone is
    component pwm is
      Port (
            clock: in std_logic;
            duty: in integer range 0 to 100 := 50;
            sig: out std_logic := '0'
      );
    end component;
signal dir: std_logic := '1';
signal count: integer range 0 to 10000000 := 0;
signal dim: std_logic;
signal mid: std_logic;
signal semi: std_logic;
signal lead: integer range -4 to 23 := 16;
begin
    --lead controls where the lead led appears
    --this goes from 16 -> -4 -> 0 -> 19 -> 15 and back
    -- this goes out of range to simulate "bounce" look
    --lights is then indexed based on this and set to the relevant pwm'ed signal
    last: pwm port map(clock => clock, duty => 25, sig => dim);
    third: pwm port map(clock => clock, duty => 50, sig => mid);
    second: pwm port map(clock => clock, duty => 75, sig => semi);
    process(clock)
    begin
        if (rising_edge(clock)) then
            if (btnC = '1') then
                count <= count + 1;
                if (count = 10000000) then
                    count <= 0;
                    if (dir = '1') then
                        if (lead = -4) then
                            lead <= 0;
                            dir <= not dir;
                        else
                            lead <= lead - 1;
                        end if;
                    else
                        if (lead = 19) then
                            lead <= 15;
                            dir <= not dir;
                        else
                            lead <= lead + 1;
                        end if;

                    end if;
                    
                end if;
                lights <= (others => '0');
                lights(lead) <= '1';
                if (dir = '1') then
                    lights(lead+1) <= semi;
                    lights(lead+2) <= mid;
                    lights(lead+3) <= dim;
                else
                    lights(lead-1) <= semi;
                    lights(lead-2) <= mid;
                    lights(lead-3) <= dim;
                end if;
            end if;
        end if;
        
    end process;

end Behavioral;
