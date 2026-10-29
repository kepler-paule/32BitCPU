-- 4 x 4 register file
-- two read ports, one write port with write enable
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity regfile_board is
port( din: in std_logic_vector(3 downto 0);
reset : in std_logic;
clk: in std_logic;
write : in std_logic;
read_a : in std_logic_vector(1 downto 0);
read_b : in std_logic_vector(1 downto 0);
write_address : in std_logic_vector(1 downto 0);
out_a : out std_logic_vector(3 downto 0);
out_b : out std_logic_vector(3 downto 0));
end regfile_board ;

architecture structural of regfile_board is

--There is a wonderful std_numeric function that turns std_logic_vectors into decimal. Ill be taking inspo.
function to_integer(x : std_logic_vector) return integer is
    variable result : integer := 0;
begin
    for i in x'range loop
        result := result * 2;
        if x(i) = '1' then
            result := result + 1;
        elsif x(i) = '0' then
            null;
        else
            report "Invalid value in binary vector, returning 0";
                return 0;
        end if;
    end loop;

    return result;
end function;

-- type needed to store my arrays 4 registers of 4 bits
type registers is array (3 downto 0) of std_logic_vector(3 downto 0);

--Signals ---

signal myRegisters : registers := (others =>(others=>'0'));
 
begin
--this can all be done in one process lowkey
process(reset, clk)
begin

if(reset = '1') then 
--set all registers to zero
myRegisters <= (others =>(others=>'0'));

elsif(rising_edge(clk)) then
--clock only in control of writing not reading
if(write ='1') then
--write to the appropriate address
myRegisters(to_integer(write_address)) <= din; 
 
end if;

end if;

end process; 

out_a <= myRegisters(to_integer(read_a));
out_b <= myRegisters(to_integer(read_b));

end structural;
