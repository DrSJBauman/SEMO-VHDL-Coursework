library ieee;
use ieee.std_logic_1164.all;

entity counter is
port(
	pb1, pb2: in std_logic;
	digit1, digit2: out std_logic_vector(7 downto 0));
end counter;

architecture ctr of counter is
	signal st, clr: std_logic;
	begin
	clr <= pb1 or pb2;
	st <= pb1 nand (pb2 nand st);
	process(st, clr)
		variable temp1: integer range 0 to 10;
		variable temp2: integer range 0 to 10;
	begin
			if (clr='0') then
				temp1 := 0;
				temp2 := 0;
			elsif (st'event and st = '0') then
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
end ctr;