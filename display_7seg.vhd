library ieee;
use ieee.std_logic_1164.all;

entity display_7seg is
	port(
		d : in std_logic_vector(3 downto 0);
		disp : out std_logic_vector (6 downto 0));
end display_7seg;

architecture seven_segment of display_7seg is
	signal input : std_logic_vector (3 downto 0);
	signal output : std_logic_vector (6 downto 0);
begin
	input <= d;
with input select
	output <= "0000001" when "0000", --display 0
			  "1001111" when "0001", --display 1
			  "0010010" when "0010", --display 2
			  "0000110" when "0011", --display 3
			  "1001100" when "0100", --display 4
			  "0100100" when "0101", --display 5
			  "1100000" when "0110", --display 6
			  "0001111" when "0111", --display 7
			  "0000000" when "1000", --display 8
			  "0001100" when "1001", --display 9
			  "1111111" when others;

--Separate the output vector to make individual pin outputs.
disp<=output;

end seven_segment;
			  