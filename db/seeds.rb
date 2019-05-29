require 'pry'

def get_data()
  api_string = 'https://data.cityofnewyork.us/resource/n4ac-3636.json'
  volunteer_data = RestClient.get(api_string)
  volunteer_json = JSON.parse(volunteer_data)
  volunteer_json
end

def populate_opportunities
  get_data.each do |opportunity|
    #binding.pry
    Opportunity.create(org_title: opportunity["title"], summary: opportunity["summary"], zipcode: opportunity["postalcode"], category_desc: opportunity["category_desc"], vol_requests: opportunity["vol_requests"], recurrence_type: opportunity["recurrence_type"], start_date: opportunity["start_date_date"])
  end
end

def populate_users
  User.create(name: "Emi", zipcode: 12335, age: 6)
  User.create(name: "Raphi", zipcode: 10003, age: 25)
  User.create(name: "Steven", zipcode: 10009, age: 23)
  User.create(name: "Gorbetha", zipcode: 12335, age: 79)
  User.create(name: "Sam", zipcode: 10023, age: 56)
end

populate_users
populate_opportunities
