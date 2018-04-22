class MachinesController < ApplicationController
  def index
  end

  def result
    @results = Shop.where({
      prefecture: params[:prefecture]
    }).map{|shop|
      shop.user_machines
    }.flatten[0..15]
  end

  def show
  end
end
