--addsub4g.vhd
library ieee;
use ieee.std_logic_1164.all;

entity add_sub is
	port(
		sub  : in std_logic;
		a, b : in std_logic_vector (4 downto 1);
		sum  : out std_logic_vector (3 downto 0);
		c4   : out std_logic;
		display  : out std_logic_vector (7 downto 1));
end add_sub;

architecture adder of add_sub is
	
	--Component declaration
	component fulladd
		port(
			a, b, c_in : in std_logic;
			c_out, sum : out std_logic);
	end component;
	
	component display_7seg
		port(
			d : in std_logic_vector(3 downto 0);
			disp : out std_logic_vector(6 downto 0));
	end component;
	
	--Define a signal for internal carry bits
	signal ans    : std_logic_vector (4 downto 0);
	signal b_comp : std_logic_vector (4 downto 0);
	signal display_out: std_logic_vector (6 downto 0);
	
begin
	--add/subtract select to carry input (sub=1 for subtract)
	ans(0)  <= sub;
	Adders:
	for i in 1 to 4 generate
		--invert b for subtract (b(i) xor 1),
		--do not invert for add (b(i) xor 0)
		b_comp(i) <= b(i) xor sub;
		adder: fulladd port map (a(i), b_comp(i), ans(i-1), ans(i), sum(i));
	end generate;
	c4 <= ans(4);
	
	AdderToDisplay: display_7seg 
				port map(
							d(3) => sum(3),
							d(2) => sum(2),
							d(1) => sum(1),
							d(0) => sum(0),
							disp(6) => display_out(6),
							disp(5) => display_out(5),
							disp(4) => display_out(4),
							disp(3) => display_out(3),
							disp(2) => display_out(2),
							disp(1) => display_out(1),
							disp(0) => display_out(0));
	
	display(1) => display_out(0);
	display(2) => display_out(1);
	display(3) => display_out(2);
	display(4) => display_out(3);
	display(5) => display_out(4);
	display(6) => display_out(5);
	display(7) => display_out(6);
					   
end adder;