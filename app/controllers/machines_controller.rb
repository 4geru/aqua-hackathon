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
  end
end
