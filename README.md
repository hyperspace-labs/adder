# _Summit_

[![Pipeline](https://github.com/hyperspace-labs/summit/workflows/Pipeline/badge.svg)](https://github.com/hyperspace-labs/summit/actions) [![License](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/license/mit) 

A collection of simple hardware units to demonstrate the capabilities of [Orbit](https://github.com/cdotrus/orbit.git).

## What is this?

This repository demonstrates an open-source and lean workflow for managing a digital hardware project mainly written in hardware description languages (HDLs).

### Highlights

- This project uses code that exists outside this repository in the form of an _dependency_ listed in the [Orbit.toml](./Orbit.toml) file under the `[dependencies]` table.

- This project uses CI/CD jobs to test the design's with each of their respective testbenches using the ModelSim simulator.

- This project uses CI/CD jobs to build the top level design ([`top`](./rtl/top.v)) using the Quartus design tool. Artifacts, such as the final bitstream, are uploaded after every push to its respective GitHub Action.

- This project showcases Orbit's ability to support Verilog and VHDL code, and mixing the two languages together ([`adder`](./rtl/adder.vhd) instantiated within [`top`](./rtl/top.v)).

### Exploration

Orbit provides commands to support faster ip development. Here is how a couple of commands look within the context of this ip:

See what design units are available:
```
$ orbit view --units
```
```
adder                               entity        public      
fa                                  entity        public      
adder_tb                            entity        private     
fa_tb                               entity        private     
top                                 module        private     
```

Get a design unit for integration:
```
$ orbit get fa --instance --name u_chain_fa
```
```
u_chain_fa: entity work.fa
  port map(
    input1 => input1,
    input2 => input2,
    carry_in => carry_in,
    sum => sum,
    carry_out => carry_out
  );
```

View the design hierarchy:
```
$ orbit tree --root top --format long
```
```
top (summit:0.1.0)
└─ adder (summit:0.1.0)
   └─ fa (summit:0.1.0)
      └─ or_gate (gates:1.0.0)
         └─ nand_gate (gates:1.0.0)
```

Run a simulation:
```
$ orbit test --target gsim --bench fa_tb
```
```
info: lockfile experienced no changes
info: dut set to fa
info: testbench set to fa_tb
info: blueprint created at: "/Users/hyperspace-labs/summit/target/gsim/blueprint.tsv"
info: analyzing source code ...
  -> "/Users/hyperspace-labs/.orbit/cache/gates-1.0.0-61da86cd60/rtl/nand_gate.vhd"
  -> "/Users/hyperspace-labs/.orbit/cache/gates-1.0.0-61da86cd60/rtl/or_gate.vhd"
  -> "/Users/hyperspace-labs/Develop/vhdl/hyperspace-labs/summit/rtl/fa.vhd"
  -> "/Users/hyperspace-labs/Develop/vhdl/hyperspace-labs/summit/sim/fa_tb.vhd"
info: starting simulation for testbench "fa_tb" ...
/Users/hyperspace-labs/summit/sim/fa_tb.vhd:40:5:@160ns:(report note): simulation complete
```

Reference in-line documentation:
```
$ orbit read adder --doc "carry_out"
```
```
    -- Overflow bit when addition exceeds `sum`'s maximum value.
    carry_out : out std_logic
```