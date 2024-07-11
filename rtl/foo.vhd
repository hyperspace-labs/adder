library ieee;
use ieee.std_logic_1164.all;

entity foo is 
  port(
    a: in std_logic;
    b: in std_logic;
    c: out std_logic
  );
end entity;

architecture gp of foo is
begin

  c <= a or b;

end architecture;