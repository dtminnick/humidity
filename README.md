
<!-- README.md is generated from README.Rmd. Please edit that file -->

# humidity

<!-- badges: start -->
<!-- badges: end -->

This package provides code used to collect relative humidity, barometric
pressure, ambient temperature and other data using a BME280 temperature
sensor connected to a Raspberry Pi.

The dataset includes time series data tracking changes in relative
humidity and related measures at regular intervals.

## Inspiration

I’ve spent time over the past several years using R to hone my data
analysis skills. My ‘to do’ list included completing a project to
generate my own source data, and I thought I could gain a wealth of
knowledge by building a hardware and software solution to track relative
humidity in my home.

I completed the initial project and started capturing sensor readings
from a single Raspberry Pi in July 2021. In September 2022, I added a
second device so I could capture readings from two floors in my house
simultaneously. My future plans include adding two additional devices so
I have one on each floor of my house and one outside.

## Installation

You can install the development version of the humidity project from
[GitHub](https://github.com/) with the following command in R:

``` r
devtools::install_github("dtminnick/humidity")
```

## Data Collection Methodology

Sensor data is captured at scheduled intervals and written to a flat,
delimited text file on remote Raspberry Pi devices. I download text
files from the devices using an SSH connection.

For more detailed documentation on the end-to-end data collection,
please refer to …

## Description of the Data

Describe how the data is organized in the ‘readings’ dataset.

## File Format

## Project Setup

For a detailed description of the process I followed to setup this
project, refer to the [setup vignette](setup.html).

## Authors

Donnie Minnick, <donnie.minnick@gmail.com>

## License

## Example
