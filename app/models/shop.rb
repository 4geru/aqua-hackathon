class Shop < ApplicationRecord

  class << self
    def new_from_hash(shop)
      new.tap do |m|
        m.id = shop["ANKSHOPID"]
        m.shop_name = shop["KNJSHOPNAME"]
        m.shop_kana_name= shop["KANASHOPNAME"]
        m.post_num= shop["ANKPOSTNUM"]
        m.prefecture= shop["KNJPREFECTURES"]
        m.address = shop["KNJADDRESS"]
        m.address_kana = shop["KNJADDRESSKANA"]
        m.business_hour = shop["MIXBUSINESSHOUR"]
        m.tel_num = shop["ANKTELNUM"]
        m.fax_num = shop["ANKFAXNUM"]
        m.hp_link = shop["MIXHPLINK"]
        m.maintenance_man = shop["KNJMAINTEMAN"]
        m.maintenance_tel_num = shop["ANKMAINTETELNUM"]
        m.business = shop["KNJBUSINESS"]
        m.business_tel_num = shop["ANKBUSINESSTELNUM"]
        m.owner_id = shop["ANKOWNERID"].to_i if shop["ANKOWNERID"].present?
        m.owner_name = shop["KNJOWNERNAME"]
        m.fc_id = shop["ANKFCID"].to_i if shop["ANKFCID"].present?
        m.fc_company_name = shop["KNJFCCOMPANYNAME"]
        m.shop_open_date = shop["DTMSHOPOPENDATE"]
        m.position = shop["MIXPOSITION"]
        m.longitude = shop["ANKLONGITUDE"]
        m.parallel = shop["ANKPARALLEL"]
        m.group_id = shop["ANKGROUPID"].to_i if shop["ANKGROUPID"].present?
        m.group_name = shop["KNJGROUPNAME"]
        m.shop_outer = Base64.decode64(shop["BINSHOPOUTER"].split(",")[1])
        m.shop_inner = Base64.decode64(shop["BINSHOPINNER"].split(",")[1])
        m.shop_outer_s = Base64.decode64(shop["BINKSHOPOUTER"].split(",")[1])
        m.shop_inner_s = Base64.decode64(shop["BINKSHOPINNER"].split(",")[1])
      end
    end
  end
end