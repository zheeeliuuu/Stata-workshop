*=======================================================
					* CSSCR Workshop *
					* Intro to Stata *

					* by Zhe Liu, July 2021
*========================================================
* help files
help contents data management

help import

* change work directory
cd "/Users/zl/OneDrive - UW/CSSCR/Stata_ Zhe_workshop"

*===========================
* importing data
*==========================

* read from hard drive
use hs0.dta, clear

* load data over internet, clear memory first
use https://stats.idre.ucla.edu/stat/data/hs0, clear

* save data, replace if it exists
save hs1, replace

* import excel file; change path below before executing
import excel "hs0.xlsx", ///
sheet("mysheet") firstrow clear

* import csv file
import delimited using "hs0.csv", clear

*=========================
* exploring data
*=========================
* load the sample data
use https://stats.idre.ucla.edu/stat/data/hs0, clear


* browse data
browse

* browse gender, ses, and read for females (gender=2) who have read > 70
browse gender ses read if gender == 2 & read > 70


* variable properties
describe

* inspect values
codebook read gender prgtype

* summarize read and math for females
summarize read math if gender == 2

* tabulate frequencies of ses
tabulate ses


*==========================
* data visualization
*==========================
* histogram of write 
histogram write

* scatter plot of write vs read
scatter write read

*==========================
* data management
*==========================

* generate a sum of 3 variables
generate total = math + science + socst

* create a dummy variable that equals 1 if prgtype equals academic, 0 otherwise
gen academic = 0
	replace academic = 1 if prgtype == "academic"

tab prgtype academic

* "egen" create vars using functions
* eg. generate variables with rowmean returns mean of all non-missing values
egen meantest = rowmean(read math science socst)

* label new variable
label var meantest " Average test score"

summarize meantest read math science socst

* encoding string var prgtype into numeric variable prog
encode prgtype, gen(prog)

*============================
* basic statistical analysis
*============================

* independent samples t-test
ttest read, by(gender)

* paired 
ttest read == write

* correlation
corr read write math science socst

* linear regression of write on predictor math and categorical predictor prog
regress write math i.prog

* logistic regression of being in academic program on female and math score
* coefficients as odds ratios

logit academic i.gender math, or


