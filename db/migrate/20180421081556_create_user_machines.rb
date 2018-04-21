class CreateUserMachines < ActiveRecord::Migration[5.2]
  def change
    create_table :user_machines do |t|
      t.integer :user_id, null: false
      t.integer :machine_id, null: false

      t.timestamps
    end
    add_index :user_machines, :user_id, unique: false
  end
end
