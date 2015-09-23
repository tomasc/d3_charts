module D3Charts
  class Chart
    class Area < Chart

      def dom_class
        super + %w(area)
      end

      def dom_data
        res = {}
        res[:date_format] = @options[:date_format]
        res[:data_date_format] = @options[:data_date_format]
        super.merge(res)
      end

    end
  end
end
