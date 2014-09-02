module D3Charts
  class Chart

    include ActionView::Helpers::TagHelper

    # ---------------------------------------------------------------------

    def initialize chart_data, options={}
      @chart_data = chart_data
    end

    def dom_class
      %w(chart container)
    end

    def tag options={}
      content_tag(:div, nil,
        {
          class: dom_class,
          data: { chart_data: (options[:data] || data.to_json) }
        }
      )
    end

  end
end