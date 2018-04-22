class HomeController < ApplicationController
  def show
    # @chart_data = {'2014-04-01' => 60, '2014-04-02' => 65, '2014-04-03' => 64}
    @chart_data = aqua_api.sales_detail(20157702, 01)
  end
end