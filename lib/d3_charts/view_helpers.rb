require 'action_view'

require_relative 'chart'

module D3Charts
  module ViewHelpers

    def self.included klass
      klass.class_eval do
        include ActionView::Context
      end
    end

    # =====================================================================

    def chart_tag chart_type, chart_data, options={}
      case chart_type
      when :pie then Chart::Pie.new(chart_data, options).tag.html_safe
      when :area then Chart::Area.new(chart_data, options).tag.html_safe
      end
    end

  end
end
