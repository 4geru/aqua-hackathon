require 'rest-client'
require 'uri'
require 'json'
require 'base64'

token = 'UbHJnfQUHElceP1OgjC8Gxuu3_a-H0ELSVXXfyBiSWeqiEQsGCLIDViK0xCR6EYpdlFkYjXYV8MJq3DEMpFqOE4FN9DE4VwAZp_h3O8YlrjSLtcBbIABEhmMymRERvjV-r1av4QK4uv5tZWVnGwPnjxywf7z9VtmgJNvk2IQBfKBG1_1U8l0hMKNkepZz-Z6pBy77xI4cR87AuUEf4NWBa8CU2py9wv1ncLFwK15OVpKJpBWf02UkJcW7PjY91MGfrdyXaPrKQBPYaLjZNGptVCwbnZCaz9P3ZwyMedCDtkpT1D-dc8SEuzUiEdaZg-moLsJlNLU61HJ2Fc25Gsqe4BblcAqitAdVCn89Dk0BDbQ0vMQKEdHe50ZNFpbBwae0EDBwEfvogD7LY14d0GxDkbJdUUfdDeOih_W8TiEfq7GsLiTcZQwuhtTa8IYWnYPGHLWQ5nq4rI41DusWNIOdmFDw9I_7qF_ALQo04yPhYE'
root = 'http://hackathon.support-cloud-projects.com/LaundromatWebApi/api/'

# == get machine detail info == 
machine = {:shop_id=>"11000123", :shop_owner_id=>"46228846", :machine_id=>"01", :machine_part_id=>"HWD-7176GC"}
path = "machinedetailsinfo?ANKOWNERID=#{machine[:shop_owner_id]}&ANKSHOPID=#{machine[:shop_id]}&ANKMACHINENUM=#{machine[:machine_id]}"
r = RestClient.get root + path, {:Authorization => "Bearer #{token}"}
data = JSON.parse(r)['DataModel'][0]


# == get machine detail info == 
path = "machineimage?ANKOWNERID=#{machine[:shop_owner_id]}&ANKSHOPID=#{machine[:shop_id]}&ANKMACHINENUM=#{machine[:machine_id]}"
r = RestClient.get root + path, {:Authorization => "Bearer #{token}"}
data = JSON.parse(r)['DataModel'][0]
  
p data['BINMACHINEIMAGE']

File.open("hoge.bmp", "wb") do |f| 
    f.write(Base64.decode64(data['BINMACHINEIMAGE']))
end