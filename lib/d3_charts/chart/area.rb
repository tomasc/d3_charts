module D3Charts
  class Chart
    class Area < Chart

      def dom_class
        super + %w(area)
      end

      def dom_data
        res = {}
        res[:margin] = @options[:margin] if @options[:margin]
        res[:format] = @options[:format] if @options[:format]
        super.merge(res)
      end

    end
  end
end