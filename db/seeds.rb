<<<<<<< HEAD
User.destroy_all
Opportunity.destroy_all
Signup.destroy_all

=======
require 'pry'
>>>>>>> 6564d2187f7931f274a96acf9e6ae3e4ced57f54

def get_data()
  api_string = 'https://data.cityofnewyork.us/resource/n4ac-3636.json'
  volunteer_data = RestClient.get(api_string)
  volunteer_json = JSON.parse(volunteer_data)
  volunteer_json
end

def populate_opportunities
  get_data.each do |opportunity|
    #binding.pry
    Opportunity.create(title: opportunity["title"], org_title: opportunity["org_title"], summary: opportunity["summary"], zipcode: opportunity["postalcode"], category_desc: opportunity["category_desc"], vol_requests: opportunity["vol_requests"], recurrence_type: opportunity["recurrence_type"], start_date: opportunity["start_date_date"])
  end
end

def populate_users
  User.create(name: "Emi", email: "emi.katsuta@gmail.com")
  User.create(name: "Raphi", email: "rsaphra@gmail.com")
  User.create(name: "Steven", email: "lonely&single@aol.com")
  User.create(name: "Gorbetha", email: "arghllggl@hotmail.com")
  User.create(name: "Sam", email: "seargantsam@gmail.com")
end

populate_users
populate_opportunities
