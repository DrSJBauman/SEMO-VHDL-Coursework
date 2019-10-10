--full_add.vhd
--Full adder: adds two bits, a and b, plus input carry
--to yield sum bit and output carry.
library ieee;
use ieee.std_logic_1164. all;

entity full_add is
port(
	a, b, c_in : in std_logic;
	c_out, sum : out std_logic);
end full_add;

architecture adder of full_add is
begin
	c_out <= ((a xor b) and c_in) or (a and b);
	sum <= (a xor b) xor c_in;
end adder;