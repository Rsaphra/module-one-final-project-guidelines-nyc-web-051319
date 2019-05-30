require 'active_record'

class Signup < ActiveRecord::Base
  belongs_to :users
  belongs_to :opportunities

  #returns true if a signup with both user && opp id matching already exists
  def self.exists?(user, opportunity)
    self.all.each do |signup|
      if signup.user_id == user.id && signup.opportunity_id == opportunity.id
        return true
      end
    end
    return false
  end

end
