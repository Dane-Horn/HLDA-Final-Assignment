library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity full_adder is
    Port ( 
        a, b, cin : in std_logic;
        s, cout: out std_logic
    );
end full_adder;

architecture Behavioral of full_adder is


begin
    -- a bit of repeated logic, but still okay to do twice
    s <= (a xor b) xor cin;
    cout <= ((a and b) or ((a xor b) and cin));
end Behavioral;
