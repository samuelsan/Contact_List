## TODO: Implement CSV reading/writing
require 'csv'

class ContactDatabase

  def self.connect
    begin
      conn = PG.connect( 
        dbname: 'contactlist',
        user: 'development',
        host: 'localhost',
        password: 'development'
        )
    rescue PG::PoorConnection
      puts "Something is wrong"
    end
  end

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

end