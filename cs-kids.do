use "mflx_kids_merged.dta"

// bysort unique_id: egen count_obs = count(unique_id)
// gen remove = count_obs != 3
// drop if remove
//
// bysort ac31: egen count_obs2 = count(ac31)
// gen remove2 = count_obs2 != 3
// drop if remove2


duplicates drop unique_id period, force


csdid ac31, ivar(unique_id) time(period) gvar(treatment) notyet

// csdid_plot, group(2) name(m1,replace) title("Group A")
csdid_plot, group(3) name(m1,replace) title("Group B")
