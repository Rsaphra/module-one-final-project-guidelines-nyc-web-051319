$current_user = nil
#prompts user and creates new User instance given input
def create_new_user
  puts "Please enter your name:"
  user_name = STDIN.gets.chomp
  puts "Please enter your email address:"
  email_address = STDIN.gets.chomp

  User.create(name: user_name, email: email_address)
  $current_user = User.find_by_attribute(:email, email_address)
  puts "Welcome #{user_name}!"
end

def login
  puts "Please enter your email address to login."
  email_address = STDIN.gets.chomp

  user = user_valid?(email_address)
  if user
    puts "Welcome back #{user.name}!"
    $current_user = User.find_by_attribute(:email, email_address)
  else
    puts "This account does not exist."
    create_new_user
  end
end


def user_valid?(email_address)
  found = User.all.find do |user|
    user.email == email_address
  end
  if found
    return found
  else
    return false
  end
end

def main_menu
 puts "Options:"
 puts "1. Search for volunteer opportunity by category"
 puts "2. Search for voluteer opportunity by zipcode"
 puts "3. Search for volunteer opportunity by organization"
 puts "4. Feeling extra generous!"
 puts "5. Top 5 Volunteer Opportunities with most needs"
 puts "6. Cancel my volunteer slot"
 puts ""
 option = STDIN.gets.chomp
 main_menu_selection(option)
end

def main_menu_selection(option)
 case option

 when "1"
    search_by_category
  when "2"
    search_by_zipcode
  when "3"
    search_by_organization
  when "4"
    get_random_opportunity
  when "5"
    get_5_most_desperate
  when "6"
    puts "six"
  end
end


###### Helper Methods #######

def offer_signup
  puts "Would you like to sign up for any Opportunity?"
  user_title = STDIN.gets.chomp
  matched_opportunity = Opportunity.find_by_attribute(:title, user_title)
  $current_user.signup(matched_opportunity)
  puts "Thank you for signing up!"
end

#limit range to a randomly selected start index and ten after
def limit_range(opportunities)
  start_index = rand(0..opportunities.length - 11)
  shortened = opportunities.slice(start_index...start_index + 10)
  return shortened
end

#checks to make sure more than 10 elements before limiting range
def get_limited_range(opportunities)
  if opportunities.length > 10
    return limit_range(opportunities)
  else
    return opportunities
  end
end

#format string with title and org title
def map_formatted_string(list)
  list.map do |opportunity|
    "#{opportunity.org_title} : #{opportunity.title}"
  end
end

#returns an array of event titles and summaries
def format_opportunities(opportunities)
  map_formatted_string(get_limited_range(opportunities))
end

def get_opportunities_from_attribute(attribute, input)
  opportunities = Opportunity.list_from_matching_attribute(attribute, input)
  format_opportunities(opportunities)
end

#displays list with convenient indexes
def display_list(list)
  list.each_with_index do |element, i|
    puts "#{i + 1}. #{element}"
  end
end

#displays all examples of attribute with indexes
def display_by_attribute(attribute)
  attributes = Opportunity.list_of_attributes(attribute).sort
  attributes.each_with_index do |a, i|
    puts "#{i + 1} : #{a}"
  end
end

############ for option 1 #############

#gets category user is interested in, loops until valid input
def user_category
  valid_input = false
  user_input = nil
  categories = Opportunity.list_of_attributes(:category_desc)
  while !valid_input
    puts "What category are you interested in, O magnaminous sir?"
    user_input = STDIN.gets.chomp
    # binding.pry
    if categories.include?(user_input)
      valid_input = true
    else
      puts "Not a valid category, O charitable one."
    end
  end
  user_input
end

#main search by category method
def search_by_category
  display_by_attribute(:category_desc)
  input = user_category
  short_list = get_opportunities_from_attribute(:category_desc, input)
  display_list(short_list)
end

####### for option 2 ###########

def user_zipcode
  puts "please enter your zipcode"
  valid_input = false
  user_input = nil
  zipcodes = Opportunity.list_of_attributes(:zipcode)
  while !valid_input
    user_input = STDIN.gets.chomp
    # binding.pry
    if zipcodes.include?(user_input)
      valid_input = true
    else
      puts "Not a valid zipcode, O charitable one."
    end
  end
  user_input
end

def search_by_zipcode
  input = user_zipcode
  short_list = get_opportunities_from_attribute(:zipcode, input)
  display_list(short_list)
end

####### for option 3 ###########

def user_organization
  puts "Please enter your organization"
  valid_input = false
  user_input = nil
  organizations = Opportunity.list_of_attributes(:org_title)
  while !valid_input
    user_input = STDIN.gets.chomp
    # binding.pry
    if organizations.include?(user_input)
      valid_input = true
    else
      puts "Not a valid organization, O charitable one."
    end
  end
  user_input
end

def search_by_organization
  display_by_attribute(:org_title)
  input = user_organization
  short_list = get_opportunities_from_attribute(:org_title, input)
  display_list(short_list)
end

####### for option 4 ###########

def get_random_opportunity
  rand_opp = Opportunity.return_random
  rand_title = random_opp.title
  rand_summary = random_opp.summary
  puts "Why don't you try #{rand_title}. They aim to :#{rand_summary}!"
end

####### for option 5 ###########

def get_5_most_desperate
  most_desperate = Opportunity.most_desperate_opportunities
  display_list(map_formatted_string(most_desperate))
end

#######end of option 5#########




# Options
# 1. Search for volunteer opportunity by category
# 2. Search for volunteer opportunity by location
# 3. Search for volunteer opportunity by organization
# 4. Feeling extra generous!
# 5. Top 5 Volunteer Opportunities with most needs
# 6. Cancel my volunteer slot
#



# Option 1:
#
# List of categories (with option to go back to main page)
# pick index
# return description, organization, location
# prompt SignUp? if list is NOT full
# else Error Message
# Go back to List of categories
#
#
# Option 2:
# List of locations (with option to go back to main page)
# pick index
# return
#
# Option 3:
