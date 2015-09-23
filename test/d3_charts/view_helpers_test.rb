require 'd3_charts/view_helpers'
require 'test_helper'

module D3Charts
  describe ViewHelpers do

    include ViewHelpers
    include ActionView::Helpers
    include ActionView::Helpers::TagHelper

    # =====================================================================

    describe '#chart_tag' do
      let(:data) { [{ value: 125, label: 'foo' }, { value: 325, label: 'bar' }] }

      it 'wraps the chart in a div' do
        chart_tag(:pie, data).must_match Regexp.new("<div.*?></div>")
      end

      it 'returns the correct data' do
        skip
        chart_tag(:pie, data).must_include "data-chart-data=\"#{data}\">"
      end
    end

    # ---------------------------------------------------------------------

    describe '#area_chart' do
      let(:data) { [{ date: '2014-08-02', value: 100 }, { date: '2014-09-02', value: 200 }] }

      it 'wraps the chart in a div' do
        chart_tag(:area, data).must_match Regexp.new("<div.*?></div>")
      end

      it 'returns the correct data' do
        skip
        chart_tag(:area, data).must_include "data-chart-data=\"#{data}\">"
      end
    end

    # ---------------------------------------------------------------------

  end
end
