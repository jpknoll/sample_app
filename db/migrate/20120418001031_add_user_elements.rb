class AddUserElements < ActiveRecord::Migration
  def up
  	 add_column :users, :user_name, :string
  	 add_column :users, :first_name, :string
  	 add_column :users, :last_name, :string
  	 add_column :users, :primary_instrument, :string
  	 
    add_index  :users, :user_name
    add_index  :users, :first_name
    add_index  :users, :last_name
    add_index  :users, :primary_instrument
    
  end

  def down
  end
end
