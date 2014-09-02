module D3Charts
  class Chart
    class Area < Chart

      def dom_class
        super + %w(area)
      end

    end
  end
end