rm -rf *
/pkgs/mentor/questa/10.6b/questasim/bin/vlib work
/pkgs/mentor/questa/10.6b/questasim/bin/vmap work
/pkgs/mentor/questa/10.6b/questasim/bin/vlog ../rtl/struct.sv
/pkgs/mentor/questa/10.6b/questasim/bin/vlog ../rtl/df.sv
/pkgs/mentor/questa/10.6b/questasim/bin/vlog ../rtl/dh.sv
/pkgs/mentor/questa/10.6b/questasim/bin/vlog ../rtl/ex.sv
/pkgs/mentor/questa/10.6b/questasim/bin/vlog ../rtl/alu.sv
/pkgs/mentor/questa/10.6b/questasim/bin/vlog ../rtl/id.sv
/pkgs/mentor/questa/10.6b/questasim/bin/vlog ../rtl/if.sv
/pkgs/mentor/questa/10.6b/questasim/bin/vlog ../rtl/mem.sv
/pkgs/mentor/questa/10.6b/questasim/bin/vlog ../rtl/wb.sv
/pkgs/mentor/questa/10.6b/questasim/bin/vlog ../rtl/main.sv
/pkgs/mentor/questa/10.6b/questasim/bin/vlog ../rtl/testbench.sv
\cp -r ../rtl/memory_image.txt ./
\cp -r ./memory_image.txt ./work/
chmod 777 ./work/memory_image.txt
chmod 777 ./memory_image.txt
/pkgs/mentor/questa/10.6b/questasim/bin/vsim work.tb -voptargs=+acc +MEM_IMAGE=memory_image.txt -do  "add wave sim:/tb/i_main/i_inst_fetch/* ; add wave sim:/tb/i_main/i_decode/* ;add wave sim:/tb/i_main/i_ex/* ;add wave sim:/tb/i_main/i_memory/* ;add wave sim:/tb/i_main/i_writeback/* ;add wave sim:/tb/*;run -all"

