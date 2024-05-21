use "mflx_labor_merged.dta"

* Identify entities with fewer than three observations
// bysort unique_id: egen count_obs = count(unique_id)
// gen remove = count_obs != 3
// drop if remove
//
//
// duplicates drop unique_id period, force
//
//
// save "mflx_labor_merged.dta", replace
//UNCOMMENT


// csdid total_hrs_yr, ivar(unique_id) time(period) gvar(treatment)
// csdid primary_hrs_yr, ivar(unique_id) time(period) gvar(treatment)
// csdid secondary_hrs_yr, ivar(unique_id) time(period) gvar(treatment)

global covar household_income household_head_secondary household_children city_bigger_15k

global covar_statsig household_income household_head_female household_head_secondary household_children city_bigger_15k
 


// csdid primary_hrs_yr $covar, ivar(unique_id) time(period) gvar(treatment) notyet
// estat simple, estore(csdidnocovar)
// estat pretrend
// // esttab csdidnocovar using "Figures/csdidnocov.tex"
//
// csdid secondary_hrs_yr $covar, ivar(unique_id) time(period) gvar(treatment) notyet
// estat simple 

// //
// csdid total_hrs_yr $covar, ivar(unique_id) time(period) gvar(treatment) notyet
// estat simple
// estat pretrend
// estat calendar
// csdid_plot
// graph export "Figures/total_hrs_all.gph"

// csdid_plot, group(2) name(m1,replace) title("Group A")
// csdid_plot, group(3) name(m1,replace) title("Group B")


//Head of household
// drop if age < 40
// drop if age > 55
// // drop if ls05_1 != 1
// drop if ls04 == 1
csdid total_hrs_yr $covar, ivar(unique_id) time(period) gvar(treatment) 
estat simple

