library ieee;
use ieee.std_logic_1164.all;

entity paritygencheck is
	port(
		button : in std_logic_vector(0 to 3);
		display : out std_logic_vector(0 to 4);
		error : out std_logic);
end paritygencheck;

architecture parity of paritygencheck is
	constant information : std_logic_vector(0 to 3) := "1111";
	signal p : std_logic_vector(1 to information'high);
	signal p1 : std_logic_vector(0 to information'high);
	signal p2: std_logic_vector(1 to display'high);
	
begin	
	p(1) <= information(0) xor information(1);
	
	parity_generate:
	for i in 2 to information'high generate
		p(i) <= p(i-1) xor information(i);
	end generate;
	--p <= p(information'high);
	
	
	
	transmission :
	for i in 0 to 3 generate
		p1(i) <= information(i) and button(i);
		display(i) <= p1(i);
	end generate;
	
	p2(1) <= p1(0) xor p1(1);	
	parity_check:
	for i in 2 to 3 generate
		p2(i) <= p2(i-1) xor p1(i);
	end generate;
	display(4) <= p2(3);
	
	error <= p2(3) xnor p(3);

end parity;