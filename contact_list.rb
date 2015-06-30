require_relative "contact_database.rb"
require_relative "contact.rb"

Contact.populate_list
case ARGV[0]
 
  when "help"
    puts "Menu Options: 
      new - Create a new contact
      list - List all contacts
      show - Show a contact
      find - Find a contact"

  when "new"
    puts "What is your full name?"
     full_name = STDIN.gets.chomp
    puts "What is your email?"
     email = STDIN.gets.chomp
    puts "What is your phone number?"
      phone_number = STDIN.gets.chomp
    @contacts = Contact.create(full_name, email, phone_number)
    puts "Success! New contact created!"

  when "find"
    target = ARGV[1]
    puts Contact.find(target)
  
  when "list"
    puts Contact.all

  when "show"
    target = ARGV[1]
    puts Contact.show(target)
end
