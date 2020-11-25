class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :first_name, :string 
    add_column :users, :last_name, :string 
    add_column :users, :owner, :boolean, default: false
    add_column :users, :savings, :float , default: 0
  end
end
