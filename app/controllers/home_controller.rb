class HomeController < ApplicationController
  def show
    @chart_data = aqua_api.sales_detail(20157702, 01)

    @results = UserMachine.all[0..15]
  end
end