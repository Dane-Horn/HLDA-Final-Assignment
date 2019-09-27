library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity negater is
  Port (
    num: in std_logic_vector (7 downto 0) := "00000000";
    negated: out std_logic_vector (7 downto 0)
  );
end negater;

architecture Behavioral of negater is
begin
negated <= num xor "11111111"; --literally just flips every bit, probably didn't need to make a whooollleee component for this
end Behavioral;
