## Test environments
* local R installation, R 4.0.4
* ubuntu 20.04 (on github-actions), R 4.0.4
* macOS-latest (on github-actions), R 4.0.4
* win-builder (release)
* win-builder (devel)

## R CMD check results

0 errors | 0 warnings | 0 note

* This is a new release.
* I have updated the API requests in order to comply with the following CRAN policy :
*   'Packages which use Internet resources should fail gracefully with an informative message
*   if the resource is not available or has changed (and not give a check warning nor error).'
*
* EIOPA and RFR are not mis-spelled words in DESCRIPTION : 
*   - EIOPA: European Insurance And Occupational Pensions Authority
*   - RFR: Risk-Free Rate
