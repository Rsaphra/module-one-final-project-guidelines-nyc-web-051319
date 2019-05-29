# Welcome Message
# Login (email)
# if email address exists in User class,
#   "Welcome back #{user.name}!"
# else
#   "Please sign up to use our app"
#   user_email = gets.chomp
#   user_name = gets.chomp
#   user_age = gets.chomp
#   user_location = gets.chomp
# end


def create_new_user
  puts "Please enter your name:"
  user_name = gets.chomp
  puts "Please enter your email address:"
  email_address = gets.chomp

  User.create(name: user_name, email: email_address)

  puts "Welcome #{user_name}!"
end

def login
  puts "Please enter your email address to login."
  email_address = gets.chomp

  user = user_valid?(email_address)
  if user
    puts "Welcome back #{user.name}!"
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
