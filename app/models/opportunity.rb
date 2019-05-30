require 'active_record'

class Opportunity < ActiveRecord::Base
  has_many :signups
  has_many :users, through: :signups

  #returns whether this group has met its capacity
  def isfull?
    binding.pry
    if self.vol_requests > self.signups.length
      binding.pry
      return false
    end
    return true
  end

  #returns a list of all signups that are belonging to this opportunity
  def signups
    Signup.all.select {|signup| signup.opportunity_id == self.id}
  end

  def volunteers
    signups.map do |signup|
      signup.user_id
    end
  end

  #returns a random opportunity
  def self.return_random
    rand_int = rand(0..self.all.length - 1)
    self.all[rand_int]
    #binding.pry
  end

  #returns a list of user instances that are attending this opportunity
  def users
    signups.map do |signup|
      user_id = signup.user_id
      User.all.find {|user| user.id == user_id}
    end
  end

  #returns a list of all category descriptions in Opportunity, uniq and no nil
  def self.categories
    self.all.map do |opportunity|
      opportunity.category_desc
    #make uniq and remove all nil elements in the final array
    end.uniq.reject {|x| x == nil}
  end

  #returns a list of all unique existences of an attribute
  def self.list_of_attributes(attribute)
    self.all.map do |opportunity|
      opportunity[attribute]
    end.uniq.reject {|x| x == nil}
  end

  #returns all instances the attribute matches value
  def self.list_from_matching_attribute(attribute, value)
    self.all.select do |opportunity|
      opportunity[attribute] == value
    end
  end

  def self.sorted_by_desperation
    self.all.sort_by {|opportunity| opportunity.vol_requests - opportunity.signups.length}.reverse
  end

  def self.most_desperate_opportunities
    self.sorted_by_desperation.first(5)
  end

  def self.find_by_attribute(attribute, value)
    self.all.find do |opportunity|
      opportunity[attribute] == value
    end
  end
end
