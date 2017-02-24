class AddFieldsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :first_name, :string
  	add_column :users, :last_name, :string
  	add_column :users, :gender, :integer

  	add_index :users, :confirmation_token,   unique: true
  end
end
