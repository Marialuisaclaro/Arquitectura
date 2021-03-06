# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param xicom.use_bs_reader 1
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir {C:/Users/Joaquin Camus/Documents/Progra/U/ArquiComputadores/proyecto-entrega-2-grupo-9/Entrega2/Entrega2.cache/wt} [current_project]
set_property parent.project_path {C:/Users/Joaquin Camus/Documents/Progra/U/ArquiComputadores/proyecto-entrega-2-grupo-9/Entrega2/Entrega2.xpr} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property ip_output_repo {c:/Users/Joaquin Camus/Documents/Progra/U/ArquiComputadores/proyecto-entrega-2-grupo-9/Entrega2/Entrega2.cache/ip} [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib {
  {C:/Users/Joaquin Camus/Documents/Progra/U/ArquiComputadores/proyecto-entrega-2-grupo-9/modulos/Clock_Divider.vhd}
  {C:/Users/Joaquin Camus/Documents/Progra/U/ArquiComputadores/proyecto-entrega-2-grupo-9/Entrega2/Entrega2.srcs/sources_1/new/Control_unit.vhd}
  {C:/Users/Joaquin Camus/Documents/Progra/U/ArquiComputadores/proyecto-entrega-2-grupo-9/modulos/Display_Controller.vhd}
  {C:/Users/Joaquin Camus/Documents/Progra/U/ArquiComputadores/proyecto-entrega-2-grupo-9/Entrega2/Entrega2.srcs/sources_1/imports/new/LU.vhd}
  {C:/Users/Joaquin Camus/Documents/Progra/U/ArquiComputadores/proyecto-entrega-2-grupo-9/Entrega2/Entrega2.srcs/sources_1/imports/new/MUX2.vhd}
  {C:/Users/Joaquin Camus/Documents/Progra/U/ArquiComputadores/proyecto-entrega-2-grupo-9/Entrega2/Entrega2.srcs/sources_1/new/MUX2x12.vhd}
  {C:/Users/Joaquin Camus/Documents/Progra/U/ArquiComputadores/proyecto-entrega-2-grupo-9/Entrega2/Entrega2.srcs/sources_1/new/MUX2x16.vhd}
  {C:/Users/Joaquin Camus/Documents/Progra/U/ArquiComputadores/proyecto-entrega-2-grupo-9/Entrega2/Entrega2.srcs/sources_1/imports/new/MUX4.vhd}
  {C:/Users/Joaquin Camus/Documents/Progra/U/ArquiComputadores/proyecto-entrega-2-grupo-9/Entrega2/Entrega2.srcs/sources_1/new/MUX4x12.vhd}
  {C:/Users/Joaquin Camus/Documents/Progra/U/ArquiComputadores/proyecto-entrega-2-grupo-9/Entrega2/Entrega2.srcs/sources_1/new/MUX4x16.vhd}
  {C:/Users/Joaquin Camus/Documents/Progra/U/ArquiComputadores/proyecto-entrega-2-grupo-9/Entrega2/Entrega2.srcs/sources_1/imports/new/MUX8.vhd}
  {C:/Users/Joaquin Camus/Documents/Progra/U/ArquiComputadores/proyecto-entrega-2-grupo-9/modulos/RAM.vhd}
  {C:/Users/Joaquin Camus/Documents/Progra/U/ArquiComputadores/proyecto-entrega-2-grupo-9/modulos/ROM.vhd}
  {C:/Users/Joaquin Camus/Documents/Progra/U/ArquiComputadores/proyecto-entrega-2-grupo-9/modulos/Reg.vhd}
  {C:/Users/Joaquin Camus/Documents/Progra/U/ArquiComputadores/proyecto-entrega-2-grupo-9/Entrega2/Entrega2.srcs/sources_1/new/SP.vhd}
  {C:/Users/Joaquin Camus/Documents/Progra/U/ArquiComputadores/proyecto-entrega-2-grupo-9/Entrega2/Entrega2.srcs/sources_1/new/Status.vhd}
  {C:/Users/Joaquin Camus/Documents/Progra/U/ArquiComputadores/proyecto-entrega-2-grupo-9/Entrega2/Entrega2.srcs/sources_1/new/adder12.vhd}
  {C:/Users/Joaquin Camus/Documents/Progra/U/ArquiComputadores/proyecto-entrega-2-grupo-9/Entrega2/Entrega2.srcs/sources_1/new/adder16.vhd}
  {C:/Users/Joaquin Camus/Documents/Progra/U/ArquiComputadores/proyecto-entrega-2-grupo-9/Entrega2/Entrega2.srcs/sources_1/imports/new/and2.vhd}
  {C:/Users/Joaquin Camus/Documents/Progra/U/ArquiComputadores/proyecto-entrega-2-grupo-9/Entrega2/Entrega2.srcs/sources_1/imports/new/full_adder4.vhd}
  {C:/Users/Joaquin Camus/Documents/Progra/U/ArquiComputadores/proyecto-entrega-2-grupo-9/Entrega2/Entrega2.srcs/sources_1/imports/new/or2.vhd}
  {C:/Users/Joaquin Camus/Documents/Progra/U/ArquiComputadores/proyecto-entrega-2-grupo-9/Entrega2/Entrega2.srcs/sources_1/new/program_counter.vhd}
  {C:/Users/Joaquin Camus/Documents/Progra/U/ArquiComputadores/proyecto-entrega-2-grupo-9/Entrega2/Entrega2.srcs/sources_1/new/sub16.vhd}
  {C:/Users/Joaquin Camus/Documents/Progra/U/ArquiComputadores/proyecto-entrega-2-grupo-9/Entrega2/Entrega2.srcs/sources_1/imports/new/xor3.vhd}
  {C:/Users/Joaquin Camus/Documents/Progra/U/ArquiComputadores/proyecto-entrega-2-grupo-9/Entrega2/Entrega2.srcs/sources_1/new/Principal.vhd}
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc {{C:/Users/Joaquin Camus/Documents/Progra/U/ArquiComputadores/proyecto-entrega-2-grupo-9/Entrega2/Entrega2.srcs/constrs_1/imports/new/Artix7.xdc}}
set_property used_in_implementation false [get_files {{C:/Users/Joaquin Camus/Documents/Progra/U/ArquiComputadores/proyecto-entrega-2-grupo-9/Entrega2/Entrega2.srcs/constrs_1/imports/new/Artix7.xdc}}]

set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top Principal -part xc7a35tcpg236-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef Principal.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file Principal_utilization_synth.rpt -pb Principal_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
