# https://github.com/zenorocha/jquery-boilerplate
(($, window) ->

  # ---------------------------------------------------------------------

  pluginName = 'chart_area'
  document = window.document

  defaults =
    debug: false
    width: 1000
    height: 1000
    margin: 40
    ticks: 'days'

  # ---------------------------------------------------------------------

  class Plugin

    constructor: (@element, options) ->
      @options = $.extend {}, defaults, options

      @$element = $(@element)

      @_defaults = defaults
      @_name = pluginName

      @init()

    init: ->
      @render()

    # ---------------------------------------------------------------------

    get_data: -> @$element.data 'chart-data'
    get_width: -> @$element.data('width') || @options.width
    get_height: -> @$element.data('height') || @options.height
    get_margin: -> @$element.data('margin') || @options.margin
    get_ticks: ->
      switch @$element.data('ticks') || @options.ticks
        when 'years'
          { ticks: d3.time.years, format: d3.time.format("%y") }
        when 'months'
          { ticks: d3.time.months, format: d3.time.format("%m/%y") }
        when 'days'
          { ticks: d3.time.days, format: d3.time.format("%d/%m/%y") }

    # ---------------------------------------------------------------------

    render: ->
      data = @get_data()

      console.log data

      width = @get_width() - @get_margin()*2
      height = @get_height() - @get_margin()*2
      parseDate = d3.time.format("%Y-%m-%d").parse

      x = d3.time.scale().range([0, width])
      y = d3.scale.linear().range([height, 0])

      xAxis = d3.svg.axis().scale(x).orient("bottom").ticks(@get_ticks()['ticks'], 1).tickSize(0).tickPadding(5).tickFormat(@get_ticks()['format'])
      yAxis = d3.svg.axis().scale(y).orient("left").ticks(2).tickSize(0).tickPadding(5)

      area = d3.svg.area().interpolate("basis").x((d) -> x d.label).y0(height).y1((d) -> y d.value)
      svg = d3.select(@$element[0]).append("svg").attr("width", @get_width()).attr("height", @get_height()).attr("viewBox", "0 0 #{@get_height()} #{@get_width()}").attr("xmlns", "http://www.w3.org/2000/svg").append("g").attr("transform", "translate(#{@get_margin()},#{@get_margin()})")

      data.forEach (d) ->
        d.label = parseDate(d.label)
        d.value = +d.value

      x.domain d3.extent(data, (d) -> d.label)
      y.domain [0, d3.max(data, (d) -> d.value)]

      svg.append("path").datum(data).attr("class", "area").attr("d", area)

      svg.append("g").attr("class", "x axis").attr("transform", "translate(0,#{height})").call(xAxis)
      svg.append("g").attr("class", "y axis").call(yAxis)

  # ---------------------------------------------------------------------

  # prevents multiple instantiation on same DOM element
  $.fn[pluginName] = (options) ->
    @each ->
      if !$.data(this, "plugin_#{pluginName}")
        $.data(@, "plugin_#{pluginName}", new Plugin(@, options))

  # ---------------------------------------------------------------------

)(jQuery, window)

# =====================================================================

$ ->

  $('.chart.container.area').chart_area()

  # make sure the plugin is correctly rebound to new elements
  $('body').on 'dom_update', (e) ->
    $('.chart.container.area').chart_area()
