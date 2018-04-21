require 'rest-client'
require 'uri'
require 'json'
token = 'UbHJnfQUHElceP1OgjC8Gxuu3_a-H0ELSVXXfyBiSWeqiEQsGCLIDViK0xCR6EYpdlFkYjXYV8MJq3DEMpFqOE4FN9DE4VwAZp_h3O8YlrjSLtcBbIABEhmMymRERvjV-r1av4QK4uv5tZWVnGwPnjxywf7z9VtmgJNvk2IQBfKBG1_1U8l0hMKNkepZz-Z6pBy77xI4cR87AuUEf4NWBa8CU2py9wv1ncLFwK15OVpKJpBWf02UkJcW7PjY91MGfrdyXaPrKQBPYaLjZNGptVCwbnZCaz9P3ZwyMedCDtkpT1D-dc8SEuzUiEdaZg-moLsJlNLU61HJ2Fc25Gsqe4BblcAqitAdVCn89Dk0BDbQ0vMQKEdHe50ZNFpbBwae0EDBwEfvogD7LY14d0GxDkbJdUUfdDeOih_W8TiEfq7GsLiTcZQwuhtTa8IYWnYPGHLWQ5nq4rI41DusWNIOdmFDw9I_7qF_ALQo04yPhYE'
root = 'http://hackathon.support-cloud-projects.com/LaundromatWebApi/api/'

owner_id = 46228846
path = "shopinfo?ANKOWNERID=#{owner_id}"

r = RestClient.get root + path, {:Authorization => "Bearer #{token}"}
data = JSON.parse(r)

all_data = ""
([1] * 99).inject(1){|b, i| all_data += "0#{b}"[-2..-1] + ","; b += i }

machines = data['DataModel'].map{|dm|
  shop_id = dm['ANKSHOPID']
  shop_owner_id = dm['ANKOWNERID']
  path = "machineinfo?ANKOWNERID=#{shop_owner_id}&ANKSHOPID=#{shop_id}&ANKMACHINENUM=#{all_data}"
  r = RestClient.get root + path, {:Authorization => "Bearer #{token}"}
  data = JSON.parse(r)
  data['DataModel'].map{|dm|
    {shop_id: shop_id, shop_owner_id: shop_owner_id, machine_id: dm['ANKMACHINENUM'], machine_part_id: dm['MIXPARTNUM']}
  }
}.flatten

p machines