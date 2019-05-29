class ChangeUserColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :borough
    remove_column :users, :age
    remove_column :users, :zipcode

    add_column :users, :email, :string
  end
end
