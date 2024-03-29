set projDir "D:/mojo/FSMAdder2/work/planAhead"
set projName "FSMAdder"
set topName top
set device xc6slx9-2tqg144
if {[file exists "$projDir/$projName"]} { file delete -force "$projDir/$projName" }
create_project $projName "$projDir/$projName" -part $device
set_property design_mode RTL [get_filesets sources_1]
set verilogSources [list "D:/mojo/FSMAdder2/work/verilog/mojo_top_0.v" "D:/mojo/FSMAdder2/work/verilog/edge_detector_1.v" "D:/mojo/FSMAdder2/work/verilog/button_conditioner_2.v" "D:/mojo/FSMAdder2/work/verilog/edge_detector_1.v" "D:/mojo/FSMAdder2/work/verilog/button_conditioner_2.v" "D:/mojo/FSMAdder2/work/verilog/edge_detector_1.v" "D:/mojo/FSMAdder2/work/verilog/button_conditioner_2.v" "D:/mojo/FSMAdder2/work/verilog/reset_conditioner_7.v" "D:/mojo/FSMAdder2/work/verilog/pipeline_8.v" "D:/mojo/FSMAdder2/work/verilog/pipeline_8.v" "D:/mojo/FSMAdder2/work/verilog/pipeline_8.v"]
import_files -fileset [get_filesets sources_1] -force -norecurse $verilogSources
set ucfSources [list "D:/mojo/FSMAdder2/constraint/custom.ucf" "D:/Mojo\ IDE/library/components/io_shield.ucf" "D:/Mojo\ IDE/library/components/mojo.ucf"]
import_files -fileset [get_filesets constrs_1] -force -norecurse $ucfSources
set_property -name {steps.bitgen.args.More Options} -value {-g Binary:Yes -g Compress} -objects [get_runs impl_1]
set_property steps.map.args.mt on [get_runs impl_1]
set_property steps.map.args.pr b [get_runs impl_1]
set_property steps.par.args.mt on [get_runs impl_1]
update_compile_order -fileset sources_1
launch_runs -runs synth_1
wait_on_run synth_1
launch_runs -runs impl_1
wait_on_run impl_1
launch_runs impl_1 -to_step Bitgen
wait_on_run impl_1
