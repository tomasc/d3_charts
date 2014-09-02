module D3Charts
  class Chart

    include ActionView::Helpers::TagHelper

    # ---------------------------------------------------------------------

    def initialize chart_data, options={}
      @chart_data = chart_data
      @options = options
    end

    def dom_class
      %w(chart container)
    end

    def dom_data
      res = {}
      res[:chart_data] = @chart_data.to_json
      res[:width] = @options[:width] if @options[:width]
      res[:height] = @options[:height] if @options[:height]
      res
    end

    def tag
      content_tag(:div, nil, { class: dom_class, data: dom_data })
    end

  end
end