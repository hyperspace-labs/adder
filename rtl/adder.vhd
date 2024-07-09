-- Project: Summit
-- Entity: adder
-- 
-- Instantiates 6 full adders to create a 6-bit ripple carry adder
-- architecture.

library ieee;
use ieee.std_logic_1164.all;
library work;

entity adder is
    port(
        input1    : in  std_logic_vector(4 downto 0);
        input2    : in  std_logic_vector(4 downto 0);
        carry_in  : in  std_logic;
        sum       : out std_logic_vector(4 downto 0);
        carry_out : out std_logic
    );
end entity;


architecture struct of adder is

    -- internal signal to propagate carry bit through each full adder
    signal carry_i: std_logic_vector(5 downto 0) := (others => '0');

begin
    -- first bit being carried in to adder
    carry_i(0) <= carry_in;

    -- generate 6 full adder instances  
    ripple_carry: for ii in 0 to 4 generate
        u_fa_chain: entity work.fa 
          port map(
            input1    => input1(ii),
            input2    => input2(ii),
            carry_in  => carry_i(ii),
            sum       => sum(ii),
            carry_out => carry_i(ii+1)
          );
    end generate ripple_carry;

    -- last bit is to be carried out from adder
    carry_out <= carry_i(5);

end architecture;