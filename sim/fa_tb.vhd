library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fa_tb is  
end fa_tb;

architecture sim of fa_tb is

  signal input1, input2, carry_in, sum, carry_out : std_logic;
  
begin

  dut: entity work.fa 
    port map (
      input1    => input1,
      input2    => input2,
      carry_in  => carry_in,
      sum       => sum,
      carry_out => carry_out
    );

  process
    variable temp : std_logic_vector(2 downto 0);
  begin

    for i in 0 to 7 loop
      temp := std_logic_vector(to_unsigned(i,3));
      input1 <= temp(2);
      input2 <= temp(1);
      carry_in <= temp(0);
	    
      wait for 20 ns;

      assert(sum = (input1 xor input2 xor carry_in)) report "sum failed";
      assert(carry_out = ((input1 and input2) or (input1 and carry_in) or (input2 and carry_in))) report "carry failed";     
    
    end loop;

    report "simulation complete";
    wait;
  end process;
  

end architecture;