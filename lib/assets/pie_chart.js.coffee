# https://github.com/zenorocha/jquery-boilerplate
(($, window) ->



  # ---------------------------------------------------------------------



  pluginName = 'chart_pie'
  document = window.document

  defaults =
    debug: false
    width: 500
    height: 500



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

      @$element.find('svg path').qtip
        style: 'qtip-tipsy'
        position:
          my: 'bottom left'
          at: 'center'



    # ---------------------------------------------------------------------



    get_data: ->
      @$element.data 'chart-data'

    get_radius: ->
      Math.min(@get_width(), @get_height()) / 2

    get_width: ->
      @$element.data('width') || @options.width

    get_height: ->
      @$element.data('height') || @options.height



    # ---------------------------------------------------------------------



    render: ->
      data = @get_data()

      arc = d3.svg.arc().outerRadius(@get_radius()).innerRadius(0)
      pie = d3.layout.pie().sort(null).value (d) -> d.value
      svg = d3.select(@$element[0]).append("svg").attr("width", @get_width()).attr("height", @get_height()).append("g").attr("transform", "translate(#{@get_width()/2},#{@get_height()/2})")

      g = svg.selectAll(".arc").data(pie(data)).enter().append("g").attr("class", "arc")
      g.append("path").attr("d", arc).attr("class", (d) => "color_#{@get_data().indexOf(d.data)}").attr("title", (d) -> d.data.label)



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



  $('.chart.container.pie').chart_pie()

  # make sure the plugin is correctly rebound to new elements
  $('body').on 'dom_update', (e) ->
    $('.chart.container.pie').chart_pie()


