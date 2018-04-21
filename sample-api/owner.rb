require 'rest-client'
require 'uri'
require 'json'
token = 'UbHJnfQUHElceP1OgjC8Gxuu3_a-H0ELSVXXfyBiSWeqiEQsGCLIDViK0xCR6EYpdlFkYjXYV8MJq3DEMpFqOE4FN9DE4VwAZp_h3O8YlrjSLtcBbIABEhmMymRERvjV-r1av4QK4uv5tZWVnGwPnjxywf7z9VtmgJNvk2IQBfKBG1_1U8l0hMKNkepZz-Z6pBy77xI4cR87AuUEf4NWBa8CU2py9wv1ncLFwK15OVpKJpBWf02UkJcW7PjY91MGfrdyXaPrKQBPYaLjZNGptVCwbnZCaz9P3ZwyMedCDtkpT1D-dc8SEuzUiEdaZg-moLsJlNLU61HJ2Fc25Gsqe4BblcAqitAdVCn89Dk0BDbQ0vMQKEdHe50ZNFpbBwae0EDBwEfvogD7LY14d0GxDkbJdUUfdDeOih_W8TiEfq7GsLiTcZQwuhtTa8IYWnYPGHLWQ5nq4rI41DusWNIOdmFDw9I_7qF_ALQo04yPhYE'
root = 'http://hackathon.support-cloud-projects.com/LaundromatWebApi/api/'

owner_id = 20180183
path = "shopinfo?ANKOWNERID=#{owner_id}"

r = RestClient.get root + path, {:Authorization => "Bearer #{token}"}
data = JSON.parse(r)

owner = data['DataModel'][0]

puts "shop"
puts "\tKNJSHOPNAME\t #{owner['KNJSHOPNAME']}"
puts "\tKANASHOPNAME\t #{owner['KANASHOPNAME']}"
puts "\tANKSHOPID\t #{owner['ANKSHOPID']}"
puts "owner info"
puts "\tKNJOWNERNAME\t #{owner['KNJOWNERNAME']}"
puts "\tANKOWNERID\t #{owner['ANKOWNERID']}"
puts "\tKNJGROUPNAME\t#{owner['KNJGROUPNAME']}"
puts "company"
puts "\tKNJFCCOMPANYNAME\t#{owner['KNJFCCOMPANYNAME']}"