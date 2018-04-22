class UserMachinesController < ApplicationController

  def index
    @shops_hash = aqua_api.shops.each_with_object({}) { |s, h| h[s["ANKSHOPID"]] = s }
    @machines = aqua_api.machines
    @sales = UserMachine.where( "user_id = ?", current_user.id )
    .map{|m| [ m[:shop_id], m[:machine_num]] }
  end

  def show
    machine = aqua_api.machine_detail(params[:shop_id], params[:machine_id])
    @shop = aqua_api.shop(params[:shop_id])
    @anual_sales = aqua_api.anual_sales(params[:shop_id], params[:machine_id])
    @user_machine = new_user_machine(machine)
  end

  def create
    machine = aqua_api.machine_detail(user_machine_params[:shop_id], user_machine_params[:machine_num])
    anual_sales = aqua_api.anual_sales(user_machine_params[:shop_id], user_machine_params[:machine_num])
    user_machine = new_user_machine(machine).tap do |m|
      m.price = user_machine_params[:price]
      m.management_free = user_machine_params[:management_free]
      m.anual_sales = anual_sales
      m.interest = (anual_sales / m.price).to_f.round(3)
    end
    old = UserMachine.where(
      "user_id = ? and shop_id = ? and machine_num = ?",
      current_user.id,
      user_machine_params[:shop_id].to_i,
      user_machine_params[:machine_num].to_i
    )
    old.destroy_all if old.present?
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

  def new_user_machine(machine)
    @user_machine = UserMachine.new.tap do |m|
      m.user_id = current_user.id
      m.shop_id = machine["ANKSHOPID"].to_i
      m.machine_num = machine["ANKMACHINENUM"].to_i
      m.machine_short_name = machine["KNJMACHNAME"]
      m.manufacture = machine["ANKMANUFACTURE"]
      m.drum = machine["ANKDRUM"]
      m.part_num = machine["MIXPARTNUM"]
      m.machine_name = machine["KNJMACHINENAME"]
      m.capacity = machine["NUMCAPACITY"]
      m.process = machine["ANKPROCESS"]
      m.payment = machine["ANKPAYMENT"]
      m.machine_image = Base64.decode64(machine["BINMACHINEIMAGE"].split(",")[1])
    end
  end
end