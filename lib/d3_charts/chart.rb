module D3Charts
  class Chart
    include ActionView::Helpers::TagHelper

    def initialize(chart_data, options = {})
      @chart_data = chart_data
      @options = options
    end

    def dom_class
      %w(chart container)
    end

    def dom_data
      res = {}
      res[:chart_data] = @chart_data.to_json
      res[:chart_type] = chart_type
      res[:width] = @options[:width]
      res[:height] = @options[:height]
      res
    end

    def tag
      content_tag(:div, nil, class: dom_class, data: dom_data.delete_if { |_k, v| v.blank? })
    end
  end
end
