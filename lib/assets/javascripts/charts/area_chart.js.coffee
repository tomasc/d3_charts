# https://github.com/zenorocha/jquery-boilerplate
(($, window) ->

  # ---------------------------------------------------------------------

  pluginName = 'chart_area'
  document = window.document

  defaults =
    debug: false
    width: 1000
    height: 1000
    ticks: 'months'
    data_date_format: "%Y-%m-%d"
    date_format: "%Y-%m-%d"

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

    get_data: -> @$element.data 'chart-data' || []
    get_data_date_format: -> @$element.data('data-date-format') || @options.data_date_format
    get_date_format: -> @$element.data('date-format') || @options.date_format
    get_height: -> @$element.data('height') || @options.height
    get_ticks: ->
      switch @$element.data('ticks') || @options.ticks
        when 'days' then d3.time.days
        when 'months' then d3.time.months
        when 'years' then d3.time.years
    get_width: -> @$element.data('width') || @options.width

    # ---------------------------------------------------------------------

    render: ->
      data = @get_data()

      width = @get_width()
      height = @get_height()
      parseDate = d3.time.format(@get_data_date_format()).parse

      x = d3.time.scale().range([0, width])
      y = d3.scale.linear().range([height, 0])

      xAxis = d3.svg.axis().scale(x).orient("bottom").ticks(@get_ticks(), 1).tickSize(0).tickPadding(5).tickFormat(d3.time.format(@get_date_format()))
      yAxis = d3.svg.axis().scale(y).orient("left").ticks(2).tickSize(0).tickPadding(5)

      area = d3.svg.area().interpolate("basis").x((d) -> x d.label).y0(height).y1((d) -> y d.value)
      svg = d3.select(@$element[0]).append("svg").attr("width", @get_width()).attr("height", @get_height()).attr("viewBox", "0 0 #{@get_height()} #{@get_width()}").attr("xmlns", "http://www.w3.org/2000/svg").append("g")

      data.forEach (d) ->
        d.label = parseDate(d.date)
        d.value = +d.value

      x.domain d3.extent(data, (d) -> d.label)
      y.domain [0, d3.max(data, (d) -> d.value)]

      svg.append("path").datum(data).attr("class", "area").attr("d", area)

      svg.append("g").attr("class", "x axis").attr("transform", "translate(0,#{height})").call(xAxis)
      svg.append("g").attr("class", "y axis").call(yAxis)

      @$element.trigger 'chart.render'

  # ---------------------------------------------------------------------

  # prevents multiple instantiation on same DOM element
  $.fn[pluginName] = (options) ->
    @each ->
      if !$.data(this, "plugin_#{pluginName}")
        $.data(@, "plugin_#{pluginName}", new Plugin(@, options))

  # ---------------------------------------------------------------------

)(jQuery, window)

# =====================================================================

$ -> $('.chart.container.area').chart_area()
