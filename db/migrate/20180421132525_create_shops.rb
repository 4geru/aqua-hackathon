class CreateShops < ActiveRecord::Migration[5.2]
  def change
    create_table :shops do |t|
      t.string :shop_name, null: false
      t.string :shop_kana_name, null: false
      t.string :post_num, null: false
      t.string :prefecture, null: false
      t.string :address, null: false
      t.string :address_kana, null: false
      t.string :business_hour
      t.string :tel_num
      t.string :fax_num
      t.string :hp_link
      t.string :maintenance_man
      t.string :maintenance_tel_num
      t.string :business
      t.string :business_tel_num
      t.integer :owner_id
      t.string :owner_name
      t.integer :fc_id
      t.string :fc_company_name
      t.string :shop_open_date
      t.string :position
      t.float :longitude
      t.float :parallel
      t.integer :group_id
      t.string :group_name
      t.binary :shop_outer
      t.binary :shop_inner
      t.binary :shop_outer_s
      t.binary :shop_inner_s
    end
  end
end
