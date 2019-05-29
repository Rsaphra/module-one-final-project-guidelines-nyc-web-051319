class CreateOpportunities < ActiveRecord::Migration[5.0]
  def change
    create_table :opportunities do |t|
      t.string :org_title
      t.string :summary
      t.integer :zipcode
      t.string :borough
      t.string :category_desc
      t.integer :vol_requests
      t.string :recurrence_type
      t.string :start_date
    end
  end
end
