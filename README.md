
<!-- README.md is generated from README.Rmd. Please edit that file -->

# humidity

<!-- badges: start -->
<!-- badges: end -->

This package provides code used to collect relative humidity, barometric
pressure, ambient temperature and other data using a BME280 temperauture
sensor connected to a Raspberry Pi.

The dataset includes time series data tracking changes in relative
humidity and related measures at regular intervals.

## Installation

You can install the development version of humidity from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("dtminnick/humidity")
```

## Data Collection Methodology

Sensor data is captured at scheduled intervals and written to a flat,
delimited text file on a Raspberry Pi. The text file is downloaded from
the Pi using an SSH connection.

For more detailed documentation on the end-to-end data collection,
please refer to …

## Description of the Data

Here you can descibe how the data is organized in this whole dataset.
How the data is stored in all the files. You also have to brief about
the naming convention of the files in different directories.

## File Format

If the data includes images or audio, you can mention the file format
eg.(.svg, .png, .mpeg).

## Authors

## License

This project is licensed under the MIT License - see the LICENSE.md file
for details.

## Example
