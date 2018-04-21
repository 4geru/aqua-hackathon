class UserMachinesController < ApplicationController
  def index
    owner_id = 46228846
    oac = OwnerApiController.new(owner_id)
    @shops = oac.get_shops
    @machines = oac.get_machines.map{|machine|
      oac.get_machine_detail(machine[:shop_id], machine[:machine_id])
    }
  end

  def show
  end
end