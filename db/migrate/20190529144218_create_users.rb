class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :zipcode
      t.string :borough
      t.integer :age
    end
  end
end
