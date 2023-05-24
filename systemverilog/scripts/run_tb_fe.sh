
/pkgs/mentor/questa/10.6b/questasim/bin/vlib work
/pkgs/mentor/questa/10.6b/questasim/bin/vmap work
/pkgs/mentor/questa/10.6b/questasim/bin/vlog ../rtl/main.sv
/pkgs/mentor/questa/10.6b/questasim/bin/vlog ../rtl/tb.sv
/pkgs/mentor/questa/10.6b/questasim/bin/vsim -debugDB tb -do  "add wave sim:/tb/* ; run -all"

