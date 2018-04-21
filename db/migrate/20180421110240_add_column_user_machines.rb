class AddColumnUserMachines < ActiveRecord::Migration[5.2]
  def change
    remove_column :user_machines, :machine_id, :integer, null: false, default: 0
    add_column :user_machines, :shop_id, :integer, null: false, default: 0, after: :owner_id
    add_column :user_machines, :machine_num, :integer, null: false, default: 0, after: :shop_id
    add_column :user_machines, :machine_short_name, :string, after: :machine_num
    add_column :user_machines, :manufacture, :string, after: :machine_short_name
    add_column :user_machines, :drum, :string, after: :manufacture
    add_column :user_machines, :part_num, :string, after: :drum
    add_column :user_machines, :machine_name, :string, after: :part_num
    add_column :user_machines, :capacity, :string, after: :machine_name
    add_column :user_machines, :process, :string, after: :capacity
    add_column :user_machines, :payment, :string, after: :process
    add_column :user_machines, :price, :integer, null: false, default: 0, after: :payment
    add_column :user_machines, :management_free, :integer, null: false, default: 0, after: :price
    add_column :user_machines, :interest, :float, after: :management_free
    add_column :user_machines, :machine_image, :binary, after: :interest
  end
end
