library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;


entity add_sub_board is
  port(x, y : in std_logic_vector(3 downto 0);
       add_sub: in std_logic;
       result : out std_logic_vector(3 downto 0));
end add_sub_board;

architecture structural of add_sub_board is

begin

process(x,y,add_sub)
begin
if( add_sub = '0') then result <= x + y;

elsif (add_sub = '1') then result <= x - y;

else result <= x + y;

end if;

end process;

end structural;
