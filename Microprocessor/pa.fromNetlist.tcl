
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name Microprocessor -dir "/csehome/sjarelkral/Work/Microprocessor/Microprocessor/planAhead_run_3" -part xc3s50antqg144-5
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "/csehome/sjarelkral/Work/Microprocessor/Microprocessor/Microprocessor.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {/csehome/sjarelkral/Work/Microprocessor/Microprocessor} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "Microprocessor.ucf" [current_fileset -constrset]
add_files [list {Microprocessor.ucf}] -fileset [get_property constrset [current_run]]
link_design
