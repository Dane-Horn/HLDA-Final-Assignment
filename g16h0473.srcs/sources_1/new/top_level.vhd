
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
        r, g, b: out std_logic_vector(3 downto 0);
        vsync, hsync: out std_logic;
        btnC: in std_logic;
        clock: in std_logic;
        fnum: in STD_LOGIC_VECTOR(7 downto 0);
        snum: in STD_LOGIC_VECTOR(7 downto 0);
        seg: out std_logic_vector (0 to 6);
        an: out std_logic_vector (3 downto 0);
        led: out std_logic_vector (15 downto 0)
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
    
    component kitt_clone is
      Port (
        btnC : in std_logic;
        clock : in std_logic;
        lights: out std_logic_vector(15 downto 0)
      );
    end component; 
    
    component vga_display is
        Port (
            clock  : in std_logic;
            r             : OUT STD_LOGIC_VECTOR (3 downto 0);
            g             : OUT STD_LOGIC_VECTOR (3 downto 0);
            b             : OUT STD_LOGIC_VECTOR (3 downto 0);
            
            vsync         : OUT STD_LOGIC;
            hsync         : OUT STD_LOGIC
        );
    end component;
    
    
    signal neg_snum: std_logic_vector (7 downto 0) := "00000000";
    signal sub_result: std_logic_vector (7 downto 0) := "00000000";
    signal carry: std_logic := '0';
    signal no_duty: integer range 0 to 100 := 0;
    signal low_duty: integer range 0 to 100 := 10;
    signal norm_duty: integer range 0 to 100 := 50;
    signal high_duty: integer range 0 to 100 := 90;
    signal full_duty: integer range 0 to 100 := 100;
    signal kitt_lights: std_logic_vector(15 downto 0) := "0000000000000000";
begin
    hex_d: hex_display port map(clock => clock, num => sub_result, seg => seg, an => an);
    neg: negater port map(num => snum, negated => neg_snum);
    ripple: ripple_adder port map(fnum => fnum, snum => neg_snum, result => sub_result, final_carry => carry);
    kitt: kitt_clone port map(clock => clock, lights => kitt_lights, btnC => btnC);
    vga: vga_display port map (clock => clock, r => r, g => g, b => b, vsync => vsync, hsync => hsync);
    process(clock)
    begin
        if (rising_edge(clock)) then 
            if (btnC = '1') then
                led <= kitt_lights;
            else
                led(7 downto 0) <= sub_result;
                led(14 downto 8) <= (others => '0');
                led(15) <= carry;
            end if;
        end if;
    end process;
    
end Behavioral;
