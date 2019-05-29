class DeleteBorough < ActiveRecord::Migration[5.2]
  def change
    remove_column :opportunities, :borough
  end
end
