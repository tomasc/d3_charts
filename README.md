# d3_charts

[![Build Status](https://travis-ci.org/tomasc/d3_charts.svg)](https://travis-ci.org/tomasc/d3_charts) [![Gem Version](https://badge.fury.io/rb/d3_charts.svg)](http://badge.fury.io/rb/d3_charts) [![Coverage Status](https://img.shields.io/coveralls/tomasc/d3_charts.svg)](https://coveralls.io/r/tomasc/d3_charts)

Rails helpers for building SVG charts using the d3 library.

## Installation

Add this line to your application's Gemfile:

    gem 'd3_charts'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install d3_charts

To make it work you need to require the javascripts in `application.js`:

    //= require d3_charts

To add some basic colouring of pie charts, add the the following in `application.css`:

    *= require 'd3_charts'

## Usage

### Pie charts

    = chart_tag(:pie, data, options)

Available `options` are:

* `width`, defaults to 1000
* `height`, defaults to 1000

Which are passed in like so:

    = chart_tag(:pie, data, { width: 123, height: 123 })

### Area charts

    = chart_tag(:area, data, options)

Available `options` are:

* `width`, defaults to 1000
* `height`, defaults to 1000
* `date_format`, the strftime format of datums as rendered in the chart, defaults to `%Y-%m-%d`
* `data_date_format`, the strftime format of datums as specified in the data, defaults to `%Y-%m-%d`

Which are passed in like so:

    = chart_tag(:area, data, { width: 123, height: 123 })

## TODO:

* More charts:
  * Line Chart
  * Histogram Chart
  * Vertical Bar Chart
  * Horizontal Bar Chart

## Contributing

1. Fork it ( https://github.com/tomasc/d3_charts/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
