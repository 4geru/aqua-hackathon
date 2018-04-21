class UserMachinesController < ApplicationController

  def index
    @shops_hash = aqua_api.shops.each_with_object({}) { |s, h| h[s["ANKSHOPID"]] = s }
    @machines = aqua_api.machines
  end

  def show
    @machine = aqua_api.machine_detail(params[:shop_id], params[:machine_id])
    @shop = aqua_api.shop(params[:shop_id])
    @anual_sales = aqua_api.anual_sales(params[:shop_id], params[:machine_id])
  end
end