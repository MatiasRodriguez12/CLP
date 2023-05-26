#!/bin/bash

#-----------------------------------------------
#Multiplicador de punto flotante
#-----------------------------------------------
ghdl -a ../mulPF/fuentes/sum1b.vhd ../mulPF/fuentes/sumresNb.vhd ../mulPF/fuentes/mulNb.vhd ../mulPF/fuentes/mulPF.vhd ../mulPF/fuentes/mulPF_tb.vhd
ghdl -s ../mulPF/fuentes/mulPF.vhd ../mulPF/fuentes/mulPF_tb.vhd
ghdl -e mulPF_tb
ghdl -r mulPF_tb --vcd=mulPF_tb.vcd --stop-time=1000ns
gtkwave mulPF_tb.vcd

#-----------------------------------------------
#Multiplicador binario unsigned
#-----------------------------------------------
#ghdl -a ../mulNb/fuentes/sum1b.vhd ../mulNb/fuentes/sumresNb.vhd ../mulNb/fuentes/mulNb.vhd ../mulNb/fuentes/mulNb_tb.vhd
#ghdl -s ../mulNb/fuentes/mulNb.vhd ../mulNb/fuentes/mulNb_tb.vhd
#ghdl -e mulNb_tb
#ghdl -r mulNb_tb --vcd=mulNb_tb.vcd --stop-time=1000ns
#gtkwave mulNb_tb.vcd

#-----------------------------------------------
#Sumador restador
#-----------------------------------------------
#ghdl -a ../sumresNb/fuentes/sum1b.vhd ../sumresNb/fuentes/sumresNb.vhd  ../sumresNb/fuentes/sumresNb_tb.vhd
#ghdl -s ../sumresNb/fuentes/sumresNb.vhd ../sumresNb/fuentes/sumresNb_tb.vhd
#ghdl -e sumresNb_tb
#ghdl -r sumresNb_tb --vcd=sumresNb_tb.vcd --stop-time=1000ns
#gtkwave sumresNb_tb.vcd