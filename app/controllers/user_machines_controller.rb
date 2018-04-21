class UserMachinesController < ApplicationController
  before_action :setup

  def index
    @shops = @oac.get_shops
    @machines = @oac.get_machines.map{|machine|
      @oac.get_machine_detail(machine[:shop_id], machine[:machine_id])
    }
  end

  def show
    @shops = @oac.get_shops
    @machine = @oac.get_machine_detail(params[:shop_id], params[:machine_id])
  end

  private
    def setup
      owner_id = 46228846
      @oac = OwnerApiController.new(owner_id)
    end
end