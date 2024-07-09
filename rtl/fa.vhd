-- Project: Summit
-- Entity: fa
-- 
-- Take in 3 bits (input1, input2, carry_in) and perform standard addition
-- in strictly combinational logic.

library ieee;
use ieee.std_logic_1164.all;

entity fa is
    port (
        input1    : in  std_logic;
        input2    : in  std_logic;
        carry_in  : in  std_logic;
        sum       : out std_logic;
        carry_out : out std_logic
    );
end entity;


architecture gp of fa is

begin
    -- assert when an odd amount of inputs bits are high
    sum <= (carry_in and ((input1 nor input2) or (input1 and input2))) or
           (not carry_in and (input1 xor input2));

    -- assert when there are 2 or more input bits high
    carry_out <= (input1 and input2) or (input1 and carry_in) or (input2 and carry_in);

end architecture;


architecture struct of fa is

    signal lh, rh: std_logic;

    component or_gate
        port(
          a: in std_logic;
          b: in std_logic;
          y: out std_logic
        );
    end component;

begin

    lh <= carry_in and ((input1 nor input2) or (input1 and input2));
    rh <= not carry_in and (input1 xor input2);

    u_sum: or_gate
      port map(
        a => lh,
        b => rh,
        y => sum
      );

    carry_out <= (input1 and input2) or (input1 and carry_in) or (input2 and carry_in);

end architecture;