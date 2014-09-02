module D3Charts
  class Chart
    class Pie < Chart

      def dom_class
        super + %w(pie)
      end

    end
  end
end