class AquaDataService
  TOKEN = 'UbHJnfQUHElceP1OgjC8Gxuu3_a-H0ELSVXXfyBiSWeqiEQsGCLIDViK0xCR6EYpdlFkYjXYV8MJq3DEMpFqOE4FN9DE4VwAZp_h3O8YlrjSLtcBbIABEhmMymRERvjV-r1av4QK4uv5tZWVnGwPnjxywf7z9VtmgJNvk2IQBfKBG1_1U8l0hMKNkepZz-Z6pBy77xI4cR87AuUEf4NWBa8CU2py9wv1ncLFwK15OVpKJpBWf02UkJcW7PjY91MGfrdyXaPrKQBPYaLjZNGptVCwbnZCaz9P3ZwyMedCDtkpT1D-dc8SEuzUiEdaZg-moLsJlNLU61HJ2Fc25Gsqe4BblcAqitAdVCn89Dk0BDbQ0vMQKEdHe50ZNFpbBwae0EDBwEfvogD7LY14d0GxDkbJdUUfdDeOih_W8TiEfq7GsLiTcZQwuhtTa8IYWnYPGHLWQ5nq4rI41DusWNIOdmFDw9I_7qF_ALQo04yPhYE'
  SITE = 'http://hackathon.support-cloud-projects.com/LaundromatWebApi/api/'

  def initialize(owner_id)
    @owner_id = owner_id
  end

  def shop(shop_id)
    shop = get("shopinfo?ANKOWNERID=#{@owner_id}&ANKSHOPID=#{shop_id}")
    return nil if shop.empty?
    shop[0]
  end

  def shop_image(shop_id)
    image = get("shopimage?ANKOWNERID=#{@owner_id}&ANKSHOPID=#{shop_id}")
    return nil if image.empty?
    image[0]
  end

  def shops
    @shops || @shops = get("shopinfo?ANKOWNERID=#{@owner_id}")
  end

  def shop_ids
    shops.map { |s| s["ANKSHOPID"] }
  end

  def machines
    shop_ids.map { |shop_id|
      list = get("machineinfo?ANKOWNERID=#{@owner_id}&ANKSHOPID=#{shop_id}&ANKMACHINENUM=")
      list.map { |h|
        h["ANKSHOPID"] = shop_id
        h
      }
    }.flatten
  end

  def machine_detail(shop_id, machine_num)
    detail = get("machinedetailsinfo?ANKOWNERID=#{@owner_id}&ANKSHOPID=#{shop_id}&ANKMACHINENUM=#{machine_num}")
    return nil if detail.empty?
    detail[0]["ANKSHOPID"] = shop_id
    detail[0]["ANKMACHINENUM"] = machine_num
    detail[0]
  end

  def sales_details(shop_id, machine_num, today=Time.zone.today)
    from = today.ago(1.years).strftime('%Y%m%d')
    to = today.strftime('%Y%m%d')
    #details = get("salesdetailsinfo?ANKOWNERID=#{@owner_id}&ANKSHOPID=#{shop_id}&DTMSALESDAYFROM=#{from}&DTMSALESDAYTO=#{to}")
    details = get("salesdetailsinfo?ANKOWNERID=#{@owner_id}&ANKSHOPID=#{shop_id}")
    return nil if details.empty?

    details.select { |d| d["ANKMACHINENUM"] == machine_num }
  end

  def sales_detail(shop_id, machine_num, today=Time.zone.today)
    from = today.ago(1.years).strftime('%Y%m%d')
    to = today.strftime('%Y%m%d')
    details = get("salesdetailsinfo?ANKOWNERID=#{@owner_id}&ANKSHOPID=#{shop_id}")
    sales = details.inject({}) {|sales, d|
      date = d['DTMSALESDAY'].gsub('/', '-')
      sales[date] = d['NUMKINGAKU'].to_i + (sales[date] || 0)
      sales
    }
    return nil if sales.empty?

    sales
  end

  def anual_sales(shop_id, machine_num, today=Time.zone.today)
    sales_details = sales_details(shop_id, machine_num, today)
    sales = sales_details.map { |s| s["NUMKINGAKU"].to_i }.sum
    minmax = sales_details.map { |s| s["DTMSALESDAY"] }.minmax
    min = Date.strptime(minmax[0], '%Y/%m/%d')
    max = Date.strptime(minmax[1], '%Y/%m/%d')
    diff = max - min == 0 ? 1 : max - min
    (sales / diff * 365).to_i
    (sales / (max - min) * 365).to_i
  end

  private

  def get(path)
    r = RestClient.get (SITE + path), {:Authorization => "Bearer #{TOKEN}"}
    data = JSON.parse(r)
    data['DataModel']
  end
end