class ShopsController < ApplicationController

  def outer_image
    shop_image = aqua_api.shop_image(params[:id])
    image = Base64.decode64(shop_image["BINSHOPOUTER"].split(",")[1])
    send_data(image, filename: "#{params[:shop_id]}_outer.jpeg", disposition: "inline", type: "image/jpeg")
  end

  def inner_image
    shop_image = aqua_api.shop_image(params[:id])
    image = Base64.decode64(shop_image["BINSHOPINNER"].split(",")[1])
    send_data(image, filename: "#{params[:shop_id]}_inner.jpeg", disposition: "inline", type: "image/jpeg")
  end
end