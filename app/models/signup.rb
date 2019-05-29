
class Signup < ActiveRecord::Base
  belongs_to :users
  belongs_to :opportunities
end
