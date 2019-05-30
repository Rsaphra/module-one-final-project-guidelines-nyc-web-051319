

class User < ActiveRecord::Base
  has_many :signups
  has_many :opportunities, through: :signups

  def verify_signup(opportunity)
    if opportunity.isfull?
      puts "Deepest apologies. This opportunity is full. Please do pick another"
      return false
    elsif Signup.exists?(self, opportunity)
      puts "You are already signed up for this opportunity!"
      return false
    else
      return true
    end
  end

  def signup(opportunity)
    if verify_signup(opportunity)
      Signup.create(user_id: self.id, opportunity_id: opportunity.id)
    end
  end

  def signups
    Signup.all.select {|signup| signup.user_id == self.id}
  end

  def self.find_by_attribute(attribute, value)
    self.all.find do |user|
      user[attribute] == value
    end
  end

  def opportunity_ids
    signups.map do |signup|
      signup.opportunity_id
    end
  end

  def opportunities
    opportunity_ids.map do |id|
      Opportunity.find(id).title
    end
  end

  def delete_signup(opportunity)
    signup = Signup.where(user_id: self.id, opportunity_id: opportunity.id)
    Signup.destroy(signup.ids)
  end
end
