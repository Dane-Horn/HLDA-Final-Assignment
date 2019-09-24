library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;
entity hex_display is
  Port (
    clock: in std_logic;
    num: in std_logic_vector (7 downto 0);
    seg: out std_logic_vector (0 to 6);
    an: out std_logic_vector (3 downto 0)
  );
end hex_display;

architecture Behavioral of hex_display is
    signal clock_mult: std_logic_vector(16 downto 0) := "11111111111111111";
    signal counter: std_logic_vector(16 downto 0)    := "00000000000000000";
    signal seg_no: std_logic := '0';
    signal an_b: std_logic_vector(3 downto 0) := "1111";
    signal to_print: std_logic_vector(3 downto 0) := "0000";
begin
    an <= an_b;
    clock_toggle: process(clock)
    begin
        if rising_edge(clock) then
            counter <= counter + 1;
            if counter = clock_mult then
                counter <= (others => '0');
                seg_no <= not seg_no;    
            end if;
        end if;
    end process clock_toggle;
    send_to_led: process(seg_no)
    begin
        case seg_no is
            when '0' => an_b <= "1110";
            when '1' => an_b <= "1101";
        end case;
        case an_b is
            when "1110" => to_print <= num(3 downto 0);
            when "1101" => to_print <= num(7 downto 4);
            when others => to_print <= "0000";
        end case;
    end process send_to_led;
    set_seg: process(to_print)
    begin
        case to_print is
            when "0000" => seg <= "0000001";
            when "0001" => seg <= "1001111";
            when "0010" => seg <= "0010010";
            when "0011" => seg <= "0000110";
            when "0100" => seg <= "1001100";
            when "0101" => seg <= "0100100";
            when "0110" => seg <= "0100000";
            when "0111" => seg <= "0001111";
            when "1000" => seg <= "0000000";
            when "1001" => seg <= "0000100";
            when "1010" => seg <= "0001000";
            when "1011" => seg <= "1100000";
            when "1100" => seg <= "0110001";
            when "1101" => seg <= "1000010";
            when "1110" => seg <= "0110000";
            when "1111" => seg <= "0111000";
        end case;
    end process set_seg;
end Behavioral;
