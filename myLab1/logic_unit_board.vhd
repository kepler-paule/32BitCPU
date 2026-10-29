library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity logic_unit_board is
  port(x, y : in std_logic_vector(3 downto 0);
       logic_func: in std_logic_vector(1 downto 0);
       logic_result : out std_logic_vector(3 downto 0));
end logic_unit_board;

architecture structural of logic_unit_board is 
begin

process(x,y,logic_func)

 begin
 --build switch case 
  case logic_func is
   when "00" => logic_result <= x AND y;
   when "01" => logic_result <= x  OR y;
   when "10" => logic_result <= x XOR y;
   when "11" => logic_result <= x NOR y;
   when others => logic_result <= x AND y;
  --its not possible to have a latch if we have ALL values---
  end case;
 end process;
end structural;
