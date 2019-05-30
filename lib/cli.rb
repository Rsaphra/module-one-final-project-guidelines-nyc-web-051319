$current_user = nil
#prompts user and creates new User instance given input

def welcome
  puts "
  ┬ ┬┌─┐┬  ┌─┐┌─┐┌┬┐┌─┐
  │││├┤ │  │  │ ││││├┤
  └┴┘└─┘┴─┘└─┘└─┘┴ ┴└─┘
  "
  puts "
  ┌┬┐┌─┐
   │ │ │
   ┴ └─┘
  "
  puts "
  ╔═╗┬  ┌─┐┌┬┐┬┬─┐┌─┐┌┐┌  ╔═╗┌─┐┬─┐┌─┐┌─┐
  ╠╣ │  ├─┤ │ │├┬┘│ ││││  ║  ├─┤├┬┘├┤ └─┐
  ╚  ┴─┘┴ ┴ ┴ ┴┴└─└─┘┘└┘  ╚═╝┴ ┴┴└─└─┘└─┘
  "

end

def create_new_user
  puts "Please enter your name:"
  user_name = STDIN.gets.chomp
  puts "Please enter your email address:"
  email_address = STDIN.gets.chomp

  User.create(name: user_name, email: email_address)
  $current_user = User.find_by_attribute(:email, email_address)
  puts "Welcome #{user_name}!"
end

def get_confirmation_create
  "Would you like to make an account? (y/n)"
  confirm = get_confirmation
  if confirm
    create_new_user
  else
    exit(0)
  end
end



def login
  puts "Please enter your email address to login."
  email_address = STDIN.gets.chomp
  put_break
  user = user_valid?(email_address)
  if user
    puts "Welcome back #{user.name}!"
    $current_user = User.find_by_attribute(:email, email_address)
  else
    puts "This account does not exist."
    get_confirmation_create
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
 put_break
 puts "Options:"
 puts ""
 puts "1. Search for volunteer opportunity by category"
 puts "2. Search for voluteer opportunity by zipcode"
 puts "3. Search for volunteer opportunity by organization"
 puts "4. Feeling extra generous!"
 puts "5. Top 5 Volunteer Opportunities with most needs"
 puts "6. Cancel my volunteer slot"
 puts "7. Exit Program"
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
    delete_signup
  when "7"
    puts "Thank you for using us!"
    exit(0)
  end
end


###### Helper Methods #######

def put_break
  puts "*********************************************"
  puts ""
end


#gets the input from a user based on the attribute passed in for searching
def get_confirmation
  finished = false
  confirmation = nil
  while !finished
    input = STDIN.gets.chomp
    if input == 'y'
      confirmation = true
      finished = true
    elsif input == 'n'
      confirmation = false
      finished = true
    else
      puts "Please enter valid input."
    end
  end
  confirmation
end

#gets input from user as long as it is an int and does not exceed the list length
def get_index_from_user(opportunity_list)
  finished = false
  input = nil
  while !finished
    input = STDIN.gets.chomp.to_i
    if input - 1 >= opportunity_list.length || input.class != Integer
      puts "Please enter a valid index."
    else
      finished = true
    end
  end
  return input - 1
end

#offer user y/n to singup and then if yes, sign user up, passes a list of 10 opportunity instances
def offer_signup(opportunities)
  put_break
  puts "Would you like to sign up for any Opportunity? (y/n)"
  confirm = get_confirmation
  if confirm
    puts "Please enter previously listed index."
    index = get_index_from_user(opportunities)
    matched_opportunity = opportunities[index]
    $current_user.signup(matched_opportunity)
    put_break
    puts "Thank you for signing up for \"#{matched_opportunity.title}!\""
  end
  main_menu
end

def user_input(type, attribute)
  put_break
  puts "Please enter your #{type}"
  valid_input = false
  user_input = nil
  attribute_list = Opportunity.list_of_attributes(attribute)
  while !valid_input
    user_input = STDIN.gets.chomp
    if user_input == "exit"
      return "leaving"
    elsif attribute_list.include?(user_input)
      valid_input = true
    else
      puts "Not a valid #{type}, O charitable one."
    end
  end
  user_input
end

#format string with title and org title
def map_formatted_string(list)
  list.map do |opportunity|
    "\"#{opportunity.title}\"".blue + " hosted by " + "#{opportunity.org_title}".bold
  end
end

#returns an array of event titles and summaries
def format_opportunities(opportunities)
  #binding.pry
  map_formatted_string(opportunities)
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

#returns a 10 length list of opportunities based on an attribute
def get_opportunities_from_attribute(attribute, input)
  list = Opportunity.list_from_matching_attribute(attribute, input)
  get_limited_range(list)
end

#displays elements from given list with convenient indexes
def display_list(list)
  list.each_with_index do |element, i|
    puts "#{i + 1}. #{element}"
  end
end

#displays all attributes that occur within Opportunities, with indexes
def display_by_attribute(attribute)
  attributes = Opportunity.list_of_attributes(attribute).sort
  attributes.each_with_index do |a, i|
    puts "#{i + 1} : #{a}"
  end
end

############ for option 1 #############

#main search by category method
def search_by_category
  put_break
  display_by_attribute(:category_desc)
  input = user_input("category", :category_desc)
  opportunities = get_opportunities_from_attribute(:category_desc, input)
  short_list = format_opportunities(opportunities)
  display_list(short_list)
  #binding.pry
  offer_signup(opportunities)
end

####### for option 2 ###########

def search_by_zipcode
  put_break
  input = user_input("zipcode", :zipcode)
  short_list = get_opportunities_from_attribute(:zipcode, input)
  opportunities = get_opportunities_from_attribute(:zipcode, input)
  short_list = format_opportunities(opportunities)
  display_list(short_list)
  offer_signup(opportunities)
end

####### for option 3 ###########

def search_by_organization
  put_break
  display_by_attribute(:org_title)
  input = user_input("organization", :org_title)
  opportunities = get_opportunities_from_attribute(:org_title, input)
  short_list = format_opportunities(opportunities)
  display_list(short_list)
  offer_signup(opportunities)
  main_menu
end

####### for option 4 ###########

#uses get confirmation
def signup?(opportunity)
  put_break
  puts "Would you like to signup for this opportunity? (y/n)"
  confirm = get_confirmation
  if confirm
    $current_user.signup(opportunity)
    put_break
    puts "Thank you for signing up for \"#{opportunity.title}!\""
  else
    puts "We understand. Life is complicated and busy and sometimes you have to focus on yourself."
  end
end

def get_random_opportunity
  put_break
  rand_opp = Opportunity.return_random
  rand_title = rand_opp.title
  rand_summary = rand_opp.summary
  puts "Why don't you try: #{rand_title}?\n\nThey aim to :#{rand_summary}!"
  signup?(rand_opp)
  main_menu
end

####### for option 5 ###########

def get_5_most_desperate
  put_break
  most_desperate = Opportunity.most_desperate_opportunities
  display_list(map_formatted_string(most_desperate))
  offer_signup(most_desperate)
  main_menu
end

####### for option 6 #########

#puts all user signups to the console
def display_users_signups
  put_break
  puts "Here is a list of all opportunities you've signed up for: ".bold
  put_break
  display_list($current_user.opportunities)
end

#calls delete signup method from User, puts confirmation to the console
def user_delete(input)
  opportunity = Opportunity.find_by_attribute(:title, input)
  $current_user.delete_signup(opportunity)
  puts "#{input} has now been deleted."
end

#gets user input og title
def get_user_delete
  puts "What is the title of the opportunity you would like to cancel?"
  input = user_input("Title", :title)
end

#main delete signup method
def delete_signup
  put_break
  display_users_signups
  user_delete(get_user_delete)
  main_menu
end
