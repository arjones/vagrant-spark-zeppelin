# About datasets

* **don-quijote.txt.gz**: Downloaded from [project Gutemberg](https://www.gutenberg.org/browse/authors/c#a505)

* **http_access_2003*.log.gz**: Modified version from [Star Wars Kid: The Data Dump](http://waxy.org/2008/05/star_wars_kid_the_data_dump/)

* **ipligence-lite.csv**: A Free IP location database solution to detect the country and continent of the visitor connection based on their IP address. **Please download your own!** From: [IPligence Lite Free (for non-commercial usage)](http://www.ipligence.com/free-ip-database)

* **wine.csv**: Modified version from [UCI Machine Learning Repository: Wine Dataset](http://archive.ics.uci.edu/ml/datasets/Wine)

* **airlines-delayed.json**: [A modified version of Monthly Airline Delays by Airport, 2003-2016](https://github.com/jdorfman/awesome-json-datasets#travel)

```bash
gzip -dc airlines.json.gz | \
jq -c '.[] | {
  airport: .airport.code,
  carrier: .carrier.code,
  total_flights: .statistics.flights.total,
  cancelled: .statistics.flights.cancelled,
  delayed: .statistics.flights.delayed,
  min_delayed_aircraft: .statistics."minutes delayed"."late aircraft",
  min_delayed_weather: .statistics."minutes delayed".weather,
  min_delayed_security: .statistics."minutes delayed".security,
  min_delayed_carrier: .statistics."minutes delayed".carrier,
  year: .time.year,
  month: .time.month
}' | gzip -9 > airlines-delayed.json.gz
```
