use "mflx_kids_merged.dta"

duplicates drop unique_id period, force

drop if age < 15
drop if age > 38

// drop if age < 39
// drop if age > 55


//births

global covar household_income household_head_secondary household_children city_bigger_15k
csdid ac31 $covar, ivar(unique_id) time(period) gvar(treatment) 
estat simple
estat pretrend

// pap smear

// gen pap = .
// replace pap = 1 if ac38 == 1
// replace pap = 0 if ac38 == 3
// drop if pap == .
//
// drop if age < 21
//
// //
// //
// global covar household_income household_head_secondary household_children city_bigger_15k
// csdid pap $covar, ivar(unique_id) time(period) gvar(treatment) 
// estat simple
// estat pretrend


// gen breast = .
// replace breast = 1 if ac41 == 1
// replace breast = 0 if ac41 == 3
// drop if breast == .
// //
// drop if age < 35
// //
// global covar household_income household_head_secondary household_children city_bigger_15k
// csdid breast $covar, ivar(unique_id) time(period) gvar(treatment) 
// estat simple
// estat pretrend

// drop if age > 35
//
// gen breast_months = .
// replace breast_months = ac42_11*12 if ac42_1  == 1
// replace breast_months = ac42_12 if ac42_1  == 3
//
// global covar household_income household_head_secondary household_children city_bigger_15k
// csdid breast_months $covar, ivar(unique_id) time(period) gvar(treatment) 
// estat simple


