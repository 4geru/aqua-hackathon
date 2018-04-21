class AquaDataService
  TOKEN = 'UbHJnfQUHElceP1OgjC8Gxuu3_a-H0ELSVXXfyBiSWeqiEQsGCLIDViK0xCR6EYpdlFkYjXYV8MJq3DEMpFqOE4FN9DE4VwAZp_h3O8YlrjSLtcBbIABEhmMymRERvjV-r1av4QK4uv5tZWVnGwPnjxywf7z9VtmgJNvk2IQBfKBG1_1U8l0hMKNkepZz-Z6pBy77xI4cR87AuUEf4NWBa8CU2py9wv1ncLFwK15OVpKJpBWf02UkJcW7PjY91MGfrdyXaPrKQBPYaLjZNGptVCwbnZCaz9P3ZwyMedCDtkpT1D-dc8SEuzUiEdaZg-moLsJlNLU61HJ2Fc25Gsqe4BblcAqitAdVCn89Dk0BDbQ0vMQKEdHe50ZNFpbBwae0EDBwEfvogD7LY14d0GxDkbJdUUfdDeOih_W8TiEfq7GsLiTcZQwuhtTa8IYWnYPGHLWQ5nq4rI41DusWNIOdmFDw9I_7qF_ALQo04yPhYE'
  SITE = 'http://hackathon.support-cloud-projects.com/LaundromatWebApi/api/'

  def initialize(owner_id)
    @owner_id = owner_id
  end

  def shops
    @shops || @shops = get("shopinfo?ANKOWNERID=#{@owner_id}")
  end

  def shop_ids
    shops.map { |s| s["ANKSHOPID"] }
  end

  def machines
    shop_ids.map { |shop_id|
      path = "machineinfo?ANKOWNERID=#{@owner_id}&ANKSHOPID=#{shop_id}&ANKMACHINENUM="
      list = get(path)
      list.map { |h|
        h["ANKSHOPID"] = shop_id
        h
      }
    }.flatten
  end

  def machine_detail(shop_id, machine_num)
    path = "machinedetailsinfo?ANKOWNERID=#{@owner_id}&ANKSHOPID=#{shop_id}&ANKMACHINENUM=#{machine_num}"
    detail = get(path)
    return nil if detail.empty?
    detail[0]["ANKSHOPID"] = shop_id
    detail[0]["ANKMACHINENUM"] = machine_num
    detail[0]
  end

  private

  def get(path)
    r = RestClient.get (SITE + path), {:Authorization => "Bearer #{TOKEN}"}
    data = JSON.parse(r)
    data['DataModel']
  end
end