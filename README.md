Grid usage comparison
---------------------

This app is to compare RCS usage reports with what's in the grid.
Very much a WIP / one-time-thing, but why not share with the world?


# Current use

* ``` git clone repo ```
  * ``` cd repo ```
  * ``` bundle install ```
* put usage CSV's in the repo root following the names in lib/supplier.rb
* create and ENV variable "GR_API_KEY" (grab them from the s3 key bucket)
* ``` ruby grid_id_check.rb ```
