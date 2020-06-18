
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name IMEM -dir "/csehome/sjarelkral/Work/Microprocessor/IMEM/planAhead_run_1" -part xc3s50antqg144-5
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "/csehome/sjarelkral/Work/Microprocessor/IMEM/IMEM.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {/csehome/sjarelkral/Work/Microprocessor/IMEM} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "IMEM.ucf" [current_fileset -constrset]
add_files [list {IMEM.ucf}] -fileset [get_property constrset [current_run]]
link_design
