/*
  Post-processed Stata code for 2 event study estimators (Callaway and Sant'Anna estimator, difference-in-differences with matching) for the cancer screening take-up in How Universal Healthcare Affects Individuals' Choices: The Case of Seguro Popular
  created 5/2024
  last updated 9/2024
*/

clear
global covar household_income household_head_secondary household_children city_bigger_15k

//PAP SMEAR RESULTS



//CS ESTIMATOR (Table 7.1)


//all women
use "mflx_kids_merged.dta"
duplicates drop unique_id period, force
gen pap = .
replace pap = 1 if ac38 == 1
replace pap = 0 if ac38 == 3
drop if pap == .

//display ATT weighted across times/groups, pretrends test, plot TE by time periods
csdid pap $covar, ivar(unique_id) time(period) gvar(treatment) 

//display ATT weighted across times/groups, pretrends test, plot TE by time periods
estat simple
estat pretrend
csdid_plot


//women 21+
drop if age < 21 | age > 55 //drop women not aged 21-55 in Wave 1

//CS estimator
csdid pap $covar, ivar(unique_id) time(period) gvar(treatment)

//display ATT weighted across times/groups, pretrends test, plot TE by time periods
estat simple
estat pretrend
csdid_plot //(Figure 5)
clear


//DiD w/ MATCHING (Table 8.4)
use "mflx_kids_merged.dta"
duplicates drop unique_id period, force

//2 period DiD so restrict to groups treated before period 2 and 3 (remove never treated), keep only observations from period 1 and 2
gen time = .
replace time = 0 if period == 1 //pre-treatment
replace time = 1 if period == 2 //post-treatment
drop if period == 3

drop if treatment == 0
gen treat = .
replace treat = 1 if treatment == 2 //treated (before period 2)
replace treat = 0 if treatment == 3 //not-treated before 2

//Perform propensity score matching
psmatch2 treat household_income household_head_secondary household_children city_bigger_15k, logit
pstest household_income household_head_secondary household_children city_bigger_15k, t(treat)  graph both

twoway (kdensity _pscore if treat==1,clwid(medium)) (kdensity _pscore if treat==0,clwid(thin) clcolor(black)), xti("") yti("") title("") legend(order(1 "p-score treatment" 2 "p-score control")) xlabel(0.3(.2)1) graphregion(color(white))

//Keep observations within the support of the propensity score
keep if _support != .
sort unique_id
keep if time == 0
merge 1:m unique_id using "mflx_kids_merged_t1.dta" //merge in time == 1 (same script but filtered for time == 1)
bysort unique_id: keep if _N == 1

//Run DiD estimator
gen pap = .
replace pap = 1 if ac38 == 1
replace pap = 0 if ac38 == 3
drop if pap == .
reg pap treat time treat#time, vce(robust)

//women 21+
drop if age < 21 | age > 55 //drop women not aged 21-55 in Wave 1
reg pap treat time treat#time, vce(robust)
clear





//BREAST EXAM RESULTS



//CS ESTIMATOR (Table 7.1)


//all women
use "mflx_kids_merged.dta"
duplicates drop unique_id period, force
gen breast = .
replace breast = 1 if ac41 == 1
replace breast = 0 if ac41 == 3
drop if breast == .

//display ATT weighted across times/groups, pretrends test, plot TE by time periods
csdid breast $covar, ivar(unique_id) time(period) gvar(treatment) 

//display ATT weighted across times/groups, pretrends test, plot TE by time periods
estat simple
estat pretrend
csdid_plot


//women 35+
drop if age < 35 | age > 55 //drop women not aged 35-55 in Wave 1

//CS estimator
csdid breast $covar, ivar(unique_id) time(period) gvar(treatment)

//display ATT weighted across times/groups, pretrends test, plot TE by time periods
estat simple
estat pretrend
csdid_plot //(Figure 5)
clear


//DiD w/ MATCHING (Table 8.4)
use "mflx_kids_merged.dta"
duplicates drop unique_id period, force

//2 period DiD so restrict to groups treated before period 2 and 3 (remove never treated), keep only observations from period 1 and 2
gen time = .
replace time = 0 if period == 1 //pre-treatment
replace time = 1 if period == 2 //post-treatment
drop if period == 3

drop if treatment == 0
gen treat = .
replace treat = 1 if treatment == 2 //treated (before period 2)
replace treat = 0 if treatment == 3 //not-treated before 2

//Perform propensity score matching
psmatch2 treat household_income household_head_secondary household_children city_bigger_15k, logit
pstest household_income household_head_secondary household_children city_bigger_15k, t(treat)  graph both

twoway (kdensity _pscore if treat==1,clwid(medium)) (kdensity _pscore if treat==0,clwid(thin) clcolor(black)), xti("") yti("") title("") legend(order(1 "p-score treatment" 2 "p-score control")) xlabel(0.3(.2)1) graphregion(color(white))

//Keep observations within the support of the propensity score
keep if _support != .
sort unique_id
keep if time == 0
merge 1:m unique_id using "mflx_kids_merged_t1.dta" //merge in time == 1 (same script but filtered for time == 1)
bysort unique_id: keep if _N == 1

//Run DiD estimator
gen breast = .
replace breast = 1 if ac41 == 1
replace breast = 0 if ac41 == 3
drop if breast == .
reg breast treat time treat#time, vce(robust)

//women 35+
drop if age < 35 | age > 55 //drop women not aged 21-55 in Wave 1
reg breast treat time treat#time, vce(robust)
clear
