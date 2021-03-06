class MachinesController < ApplicationController
  def index
  end

  def result
    @prefectures = Shop.all.map{|shop| shop.prefecture }.uniq
    @results = Shop.where({
      prefecture: params[:prefecture]
    }).map{|shop|
      shop.user_machines
    }.flatten[0..15]
  end
  
  def show
    @user_machine = UserMachine.where(
      user_id: params[:user_id].to_i,
      shop_id: params[:shop_id].to_i,
      machine_num: params[:machine_id].to_i
    ).first
    @shop = aqua_api.shop(params[:shop_id])
    @anual_sales = aqua_api.anual_sales(params[:shop_id], params[:machine_id])
    @chart_data = aqua_api.sales_detail(params[:shop_id].to_i, machine_num: params[:machine_id].to_i)
  end
end
