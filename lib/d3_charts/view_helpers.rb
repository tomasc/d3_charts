require 'action_view'

require_relative 'chart'

module D3Charts
  module ViewHelpers

    def self.included klass
      klass.class_eval do
        include ActionView::Context
      end
    end

    # ---------------------------------------------------------------------

    def pie_chart chart_data, options={}
      Chart::Pie.new(chart_data, options).tag.html_safe
    end

    # ---------------------------------------------------------------------

    def area_chart chart_data, options={}
      Chart::Area.new(chart_data, options).tag.html_safe
    end

    # ---------------------------------------------------------------------

  end
end