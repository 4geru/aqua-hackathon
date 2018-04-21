class OwnerApiController < ApplicationController
  def initialize(owner_id)
    @token = 'UbHJnfQUHElceP1OgjC8Gxuu3_a-H0ELSVXXfyBiSWeqiEQsGCLIDViK0xCR6EYpdlFkYjXYV8MJq3DEMpFqOE4FN9DE4VwAZp_h3O8YlrjSLtcBbIABEhmMymRERvjV-r1av4QK4uv5tZWVnGwPnjxywf7z9VtmgJNvk2IQBfKBG1_1U8l0hMKNkepZz-Z6pBy77xI4cR87AuUEf4NWBa8CU2py9wv1ncLFwK15OVpKJpBWf02UkJcW7PjY91MGfrdyXaPrKQBPYaLjZNGptVCwbnZCaz9P3ZwyMedCDtkpT1D-dc8SEuzUiEdaZg-moLsJlNLU61HJ2Fc25Gsqe4BblcAqitAdVCn89Dk0BDbQ0vMQKEdHe50ZNFpbBwae0EDBwEfvogD7LY14d0GxDkbJdUUfdDeOih_W8TiEfq7GsLiTcZQwuhtTa8IYWnYPGHLWQ5nq4rI41DusWNIOdmFDw9I_7qF_ALQo04yPhYE'
    @root = 'http://hackathon.support-cloud-projects.com/LaundromatWebApi/api/'
    @shop_owner_id = 46228846
  end

  def get_machine_detail(shop_id, machine_id)
    p shop_id, machine_id
    path = "machinedetailsinfo?ANKOWNERID=#{@shop_owner_id}&ANKSHOPID=#{shop_id}&ANKMACHINENUM=#{machine_id}"
    r = RestClient.get @root + path, {:Authorization => "Bearer #{@token}"}
    data = JSON.parse(r)['DataModel'][0]
    {
      machine_name: data['KNJMACHNAME'],
      shop_id: shop_id,
      machine_id: machine_id,
      owner_id: @owner_id,
    }
  end

  def get_machines
    path = "shopinfo?ANKOWNERID=#{@shop_owner_id}"
    r = RestClient.get @root + path, {:Authorization => "Bearer #{@token}"}
    data = JSON.parse(r)['DataModel']

    machines = data.map{|dm|
      shop_id = dm['ANKSHOPID']
      shop_owner_id = dm['ANKOWNERID']
      path = "machineinfo?ANKOWNERID=#{@shop_owner_id}&ANKSHOPID=#{shop_id}&ANKMACHINENUM="
      r = RestClient.get @root + path, {:Authorization => "Bearer #{@token}"}
      data = JSON.parse(r)
      data['DataModel'].map{|dm|
        {
          shop_id: shop_id, 
          shop_owner_id: shop_owner_id, 
          machine_id: dm['ANKMACHINENUM'], 
          machine_part_id: dm['MIXPARTNUM']
        }
      }
    }.flatten
  end

  def get_shops
    path = "shopinfo?ANKOWNERID=#{@shop_owner_id}"

    r = RestClient.get @root + path, {:Authorization => "Bearer #{@token}"}
    data = JSON.parse(r)['DataModel']

    shop_ids =  data.map{|dm| dm["ANKSHOPID"] }.uniq
    shop_ids.inject({}){|shops, shop_id|
      path = "shopinfo?ANKOWNERID=#{@shop_owner_id}&ANKSHOPID=#{shop_id}"
      r = RestClient.get @root + path, {:Authorization => "Bearer #{@token}"}
      shop = JSON.parse(r)['DataModel'][0]

      shops[shop_id] = {
        shop_id: shop_id,
        pref: shop["KNJPREFECTURES"],
        address: shop["KNJADDRESS"],
        open_data: DateTime.strptime(shop["DTMSHOPOPENDATE"], "%Y年 %m月%d日 %H"),      
      }
      shops
    }
  end
end
