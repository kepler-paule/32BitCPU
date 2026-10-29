library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
entity alu_board is
port(x_in, y_in : in std_logic_vector(3 downto 0);
add_sub : in std_logic ;
logic_func : in std_logic_vector(1 downto 0 ); 
func: in std_logic_vector(1 downto 0 ) ;
output_out: out std_logic_vector(3 downto 0) ;
overflow: out std_logic ;
zero: out std_logic);
end alu_board ;


architecture structural of alu_board is
--Declare Components --
component add_sub_unit
 port(x,y: in std_logic_vector(3 downto 0); 
 add_sub: in std_logic;
 result: out std_logic_vector(3 downto 0));
 end component;
 
 component logic_unit 
 port(x,y: in std_logic_vector(3 downto 0);
   logic_func: in std_logic_vector(1 downto 0);
   logic_result : out std_logic_vector(3 downto 0));
  end component;
  
--Create internal Signals--  

signal arith: std_logic_vector(3 downto 0);
signal logic: std_logic_vector(3 downto 0);

--prepare which behavior to run 
for add1 : add_sub_unit use entity WORK.add_sub_board(structural);
for logic1: logic_unit use entity WORK.logic_unit_board(structural);


begin
-- Instanciate Components--
add1: add_sub_unit port map(x => x_in, y => y_in, add_sub => add_sub, result => arith); 
logic1: logic_unit port map(x => x_in, y => y_in, logic_func => logic_func, logic_result => logic);
  
 --we can combine concurrent assignement and processes, because they all have a sensitivity list
overflow_detection: process( arith, add_sub, x_in, y_in)
variable cin_or_bin : std_logic_vector(3 downto 0);
 begin
 if(add_sub = '0') then
  
  cin_or_bin := ('0' & x_in(2 downto 0)) + ('0' & y_in(2 downto 0) );
  overflow <= (y_in(3) and cin_or_bin(3)) or ( x_in(3) and cin_or_bin(3)) or ( x_in(3) and y_in(3)); 
 
 elsif(add_sub ='1') then
   cin_or_bin := ('0' & x_in(2 downto 0)) - ('0' & y_in(2 downto 0) );
   overflow <= ( y_in(3) and cin_or_bin(3) ) or ( not x_in(3) and cin_or_bin(3)  ) or ( not x_in(3) and y_in(3) );
 
 else 
 --act like add_sub is 0
 cin_or_bin := ('0' & x_in(2 downto 0)) + ('0' & y_in(2 downto 0) );
 overflow <= (y_in(3) and cin_or_bin(3)) or ( x_in(3) and cin_or_bin(3)) or ( x_in(3) and y_in(3)); 
 
 end if;

end process;

zero_detection: process(arith)
 variable test_zero : std_logic_vector(3 downto 0);
 
 begin
 
 test_zero := X"0" ;
 
 if( arith = test_zero ) then
 zero <= '1';
 else 
 zero <= '0';
 end if;

end process;

output_process : process(x_in,y_in,arith, logic, func)
variable padder : std_logic_vector(3 downto 0);
variable slt_MSB : std_logic;
begin
padder := (others =>'0');

if(x_in < y_in) then slt_MSB := '1';
else slt_MSB := '0';
end if;

 case func is
 when "00" => output_out <= y_in; 
 when "01" => output_out <= padder(3 downto 1) & slt_MSB;
 when "10" => output_out <= arith;
 when "11" => output_out <= logic;
 when others => output_out <= y_in;
 end case;
 -- act like its 00
end process;

end structural;
