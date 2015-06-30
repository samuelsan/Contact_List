## TODO: Implement CSV reading/writing
require 'csv'

def get_raw_data
  output = []
  CSV.foreach('touch_contacts.csv') do |row|
    output << row
  end
  output
end

def write_new(name, email, phone_numbers)
      CSV.open('touch_contacts.csv', "a+") do |csv|
        csv << ["name", "email", "phone_numbers"]
      end
    end
