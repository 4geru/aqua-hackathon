class ChangeColumnToUserMachine < ActiveRecord::Migration[5.2]
  def change
    remove_column :user_machines, :price, :integer, null: false, default: 0, after: :payment
    remove_column :user_machines, :management_free, :integer, null: false, default: 0, after: :price
    add_column :user_machines, :price, :integer, after: :payment
    add_column :user_machines, :management_free, :integer, after: :price
    add_column :user_machines, :anual_sales, :integer, after: :management_free
  end
end
