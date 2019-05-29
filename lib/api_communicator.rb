require 'JSON'
require 'pry'
require 'rest-client'


def get_data()
  # file = 'fixtures/orgs_1.json'
  # pets_1_file = File.read(file)
  # binding.pry
  # pets_1 = JSON.parse(pets_1_file)
  # binding.pry
  api_string = 'https://data.cityofnewyork.us/resource/n4ac-3636.json'
  volunteer_data = RestClient.get(api_string)
  volunteer_json = JSON.parse(volunteer_data)
  volunteer_json
end

get_data
