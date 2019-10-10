library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity stopwatch is
generic (nbit : integer := 24);
port(
	clk:   in std_logic; --clock is from the internal oscillator at 25.175 MHz	
	pb1, pb2: in std_logic;
	digit1, digit2: out std_logic_vector(7 downto 0));
end stopwatch;

architecture clock_divider of stopwatch is
	constant temp00: unsigned := "0000000000000000000000000"; --lower limit, 25 bits (nbit downto 0)
	constant temp01: unsigned := "1111111111111111111111111"; --upper limit, ""
	
	signal clk_sl: std_logic; --it is about 1 Hz, which is used as the new clock input to the counter
	signal st, clr: std_logic;
	
	begin	
	clr <= pb1 or pb2;
	st <= pb1 nand (pb2 nand st);
	
		process(st,clr,clk,clk_sl)  --generate a slower clock signal
			variable temp: unsigned (nbit downto 0);
			variable temp1: integer range 0 to 10;
			variable temp2: integer range 0 to 10;
		begin
			if(clr='0')then
				temp:=temp00;
			elsif(clk'event and clk='1') then
				temp := temp+01;
				if (temp=temp01) then
					temp := temp00;
				end if;
			clk_sl<=temp(nbit); --the value of the most significant bit
			end if;
	
			if (clr='0') then
				temp1 := 0;
				temp2 := 0;
			elsif (clk_sl'event and clk_sl='1' and st = '0') then
				temp1 := temp1+1;
					if (temp1 = 10) then
						temp1 := 0;
						temp2 := temp2+1;
					end if;
				if(temp2 = 10) then
					temp2 := 0;
				end if;
			end if;
	
		case temp1 is
			when 0 => digit1 <= "00000011";
			when 1 => digit1 <= "10011111";
			when 2 => digit1 <= "00100101";
			when 3 => digit1 <= "00001101";
			when 4 => digit1 <= "10011001";
			when 5 => digit1 <= "01001001";
			when 6 => digit1 <= "11000001";
			when 7 => digit1 <= "00011111";
			when 8 => digit1 <= "00000001";
			when 9 => digit1 <= "00011001";
			when others => digit1 <= "11111111";
		end case;

		case temp2 is
			when 0 => digit2 <= "00000011";
			when 1 => digit2 <= "10011111";
			when 2 => digit2 <= "00100101";
			when 3 => digit2 <= "00001101";
			when 4 => digit2 <= "10011001";
			when 5 => digit2 <= "01001001";
			when 6 => digit2 <= "11000001";
			when 7 => digit2 <= "00011111";
			when 8 => digit2 <= "00000001";
			when 9 => digit2 <= "00011001";
			when others => digit2 <= "11111111";
		end case;
		end process;
end clock_divider;