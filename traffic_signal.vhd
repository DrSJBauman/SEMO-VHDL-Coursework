library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity traffic_signal is
generic (nbit : integer := 25);
port(clk, clear: in std_logic;
	 tr_lt: out std_logic_vector(7 downto 0));
end traffic_signal;

architecture light of traffic_signal is
	constant temp00: unsigned := "00000000000000000000000000";
	constant temp11: unsigned := "11111111111111111111111111";
	type state_type is (s0, s1, s2, s3, s4, s5, s6, s7);
	signal state: state_type;
	signal clk_sl: std_logic;
	
begin						--generate a slower clock signal
	process(clk, clear)
	variable temp: unsigned (nbit downto 0);
	begin
		if (clear = '0') then
			temp:=temp00;
			
		elsif (clk'event and clk='1') then
			temp:=temp+1;
			if (temp=temp11) then
				temp:=temp00;
			end if;
		clk_sl<=temp(nbit);
		end if;
		end process;		--end of clock divider
		
	process(clk)
	begin
		if clk'event and clk='1' then
			case state is
				when s0=> state <= s1;
				when s1=> state <= s2;
				when s2=> state <= s3;
				when s3=> state <= s4;
				when s4=> state <= s5;
				when s5=> state <= s6;
				when s6=> state <= s7;
				when s7=> state <= s0;
			end case;
		end if;
	end process;
	
	with state select
		tr_lt <= "11010111" when s0,
				 "11010111" when s1,
				 "11010111" when s2,
				 "10110111" when s3,
				 "01111101" when s4,
				 "01111101" when s5,
				 "01111101" when s6,
				 "01111011" when s7;		
end light;