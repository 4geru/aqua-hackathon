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
    @machine = UserMachine.where(
      user_id: params[:user_id].to_i,
      shop_id: params[:shop_id].to_i,
      machine_num: params[:machine_id].to_i
    ).first

    # @shop = @machine.shop
    # @anual_sales = aqua_api.anual_sales(params[:shop_id], params[:machine_id])

    # @user_machine = UserMachine.new_from_hash(current_user.id, machine)
  end
end
