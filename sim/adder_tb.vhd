library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder_tb is
end adder_tb;

architecture sim of adder_tb is

  signal input1, input2, sum: std_logic_vector(4 downto 0);
  signal carry_in, carry_out: std_logic;

begin 

  dut: entity work.adder
    port map (
      input1    => input1,
      input2    => input2,
      carry_in  => carry_in,
      sum       => sum,
      carry_out => carry_out
    );

  process

    function sum_test (
      constant in1 : integer;
      constant in2 : integer;
      constant cin : integer)
      return std_logic_vector is
    begin
      return std_logic_vector(to_unsigned((in1+in2+cin) mod 32, 5));
    end sum_test;

    function carry_test (
      constant in1 : integer;
      constant in2 : integer;
      constant cin : integer)
      return std_logic is
    begin
      if (in1+in2+cin > 2**5-1) then
        return '1';
      else
        return '0';
      end if;
    end carry_test;

  begin
    -- test all input combinations
    for i in 0 to 31 loop
      for j in 0 to 31 loop
        for k in 0 to 1 loop

          input1   <= std_logic_vector(to_unsigned(i, 5));
          input2   <= std_logic_vector(to_unsigned(j, 5));
          carry_in <= std_logic(to_unsigned(k, 1)(0));

          wait for 20 ns;

          assert(sum = sum_test(i,j,k)) report "sum incorrect";

          assert(carry_out = carry_test(i,j,k)) report "carry incorrect";

        end loop;
      end loop;
    end loop;
    wait;
  end process;

end architecture;