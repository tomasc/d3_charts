module D3Charts
  class Chart
    class Area < Chart

      def dom_class
        super + %w(area)
      end

      def dom_data
        super.merge({
          margin: @options.fetch(:margin)
        })
      end

    end
  end
end