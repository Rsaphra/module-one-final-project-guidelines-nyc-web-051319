class ConvertZipcodeToString < ActiveRecord::Migration[5.2]
  def change
    change_column(:opportunities, :zipcode, :string)
  end
end
