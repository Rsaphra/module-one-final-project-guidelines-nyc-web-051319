

class User < ActiveRecord::Base
  has_many :signups
  has_many :opportunities, through: :signups

end
