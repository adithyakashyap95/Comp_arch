
/pkgs/mentor/questa/10.6b/questasim/bin/vlib work
/pkgs/mentor/questa/10.6b/questasim/bin/vmap work
/pkgs/mentor/questa/10.6b/questasim/bin/vlog ../rtl/struct.sv
/pkgs/mentor/questa/10.6b/questasim/bin/vlog ../rtl/main.sv
/pkgs/mentor/questa/10.6b/questasim/bin/vlog ../rtl/tb.sv
/pkgs/mentor/questa/10.6b/questasim/bin/vlog ../rtl/df.sv
/pkgs/mentor/questa/10.6b/questasim/bin/vlog ../rtl/dh.sv
/pkgs/mentor/questa/10.6b/questasim/bin/vlog ../rtl/ex.sv
/pkgs/mentor/questa/10.6b/questasim/bin/vlog ../rtl/id.sv
/pkgs/mentor/questa/10.6b/questasim/bin/vlog ../rtl/if.sv
/pkgs/mentor/questa/10.6b/questasim/bin/vlog ../rtl/mem.sv
/pkgs/mentor/questa/10.6b/questasim/bin/vlog ../rtl/wb.sv
/pkgs/mentor/questa/10.6b/questasim/bin/vlog ../rtl/opr_ctrl.sv
/pkgs/mentor/questa/10.6b/questasim/bin/vsim -debugDB main +MEM_IMAGE=memory_image.txt -do  "add wave sim:/main/* ; run -all"

