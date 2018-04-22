class UserMachinesController < ApplicationController

  def index
    @shops_hash = aqua_api.shops.each_with_object({}) { |s, h| h[s["ANKSHOPID"]] = s }
    create_shop
    @machines = aqua_api.machines
    @sales = UserMachine.where( "user_id = ?", current_user.id )
    .map{|m| [ m.shop_id, m.machine_num] }
  end

  def show
    machine = aqua_api.machine_detail(params[:shop_id], params[:machine_id])
    @shop = aqua_api.shop(params[:shop_id])
    @anual_sales = aqua_api.anual_sales(params[:shop_id], params[:machine_id])

    @user_machine = UserMachine.new_from_hash(current_user.id, machine)
  end

  def create
    machine = aqua_api.machine_detail(user_machine_params[:shop_id], user_machine_params[:machine_num])
    anual_sales = aqua_api.anual_sales(user_machine_params[:shop_id], user_machine_params[:machine_num])
    user_machine = UserMachine.new_from_hash(current_user.id, machine).tap do |m|
      m.price = user_machine_params[:price]
      m.management_free = user_machine_params[:management_free]
      m.anual_sales = anual_sales
      m.interest = (anual_sales / m.price).to_f.round(3)
    end
    UserMachine.destroy_all_by_uqniue_keys(current_user.id, user_machine.shop_id, user_machine.machine_num)
    user_machine.save!
    redirect_to user_machines_path
  end

  def image
    machine = aqua_api.machine_detail(params[:shop_id], params[:machine_id])
    image = Base64.decode64(machine["BINMACHINEIMAGE"].split(",")[1])
    send_data(image, filename: "#{params[:shop_id]}_#{params[:machine_id]}.jpeg", disposition: "inline", type: "image/jpeg")
  end

  private

  def user_machine_params
    params[:user_machine]
  end

  def create_shop
    Shop.where(id: aqua_api.shop_ids).destroy_all
    aqua_api.shops.each do |s|
      image = aqua_api.shop_image(s["ANKSHOPID"])
      Shop.new_from_hash(s.merge(image)).save
    end
  end
end