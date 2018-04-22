class UserMachine < ApplicationRecord
  belongs_to :shop

  class << self
    def new_from_hash(user_id, machine)
      new.tap do |m|
        m.user_id = user_id
        m.shop_id = machine["ANKSHOPID"].to_i
        m.machine_num = machine["ANKMACHINENUM"].to_i
        m.machine_short_name = machine["KNJMACHNAME"]
        m.manufacture = machine["ANKMANUFACTURE"]
        m.drum = machine["ANKDRUM"]
        m.part_num = machine["MIXPARTNUM"]
        m.machine_name = machine["KNJMACHINENAME"]
        m.capacity = machine["NUMCAPACITY"]
        m.process = machine["ANKPROCESS"]
        m.payment = machine["ANKPAYMENT"]
        m.machine_image = Base64.decode64(machine["BINMACHINEIMAGE"].split(",")[1])
      end
    end

    def destroy_all_by_uqniue_keys(user_id, shop_id, machine_num)
      where(
        "user_id = ? and shop_id = ? and machine_num = ?",
        user_id,
        shop_id.to_i,
        machine_num.to_i
      ).destroy_all
    end
  end
end
