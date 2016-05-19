require 'd3_charts/view_helpers'

module D3Charts
  class Railtie < Rails::Railtie
    initializer 'd3_charts.view_helpers' do
      ActionView::Base.send :include, ViewHelpers
    end
  end
end
