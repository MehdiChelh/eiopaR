## Test environments
* local R installation, R 4.0.4
* ubuntu 20.04 (on github-actions), R 4.0.4
* macOS-latest (on github-actions), R 4.0.4
* win-builder (release)
* win-builder (devel)

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.
* EIOPA and RFR are not mis-spelled words in DESCRIPTION : 
*   - EIOPA: European Insurance And Occupational Pensions Authority
*   - RFR: Risk-Free Rate

## Resubmission
This is a resubmission. In this version I have:

* Provided a link to the used webservices in the description field of the DESCRIPTION file in the form <https:...>

* Added \value to .Rd files and explained the functions results in the documentation.
