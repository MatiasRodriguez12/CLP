#!/bin/bash
ghdl -a ./mulPF/fuentes/sum1b.vhd ./mulPF/fuentes/sumresNb.vhd ./mulPF/fuentes/mulNb.vhd ./mulPF/fuentes/mulPF.vhd ./mulPF/fuentes/mulPF_tb.vhd
ghdl -s ./mulPF/fuentes/mulPF.vhd ./mulPF/fuentes/mulPF_tb.vhd
ghdl -e mulPF_tb
ghdl -r mulPF_tb --vcd=mulPF_tb.vcd --stop-time=1000ns
gtkwave mulPF_tb.vcd