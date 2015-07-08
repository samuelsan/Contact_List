require_relative "contact_database.rb"
require_relative "contact.rb"
require 'pg'
require 'pry'

command = ARGV[0]

puts "establishing connection ..."


#Contact.connect(conn)


=begin

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
=end

def new_contact
  puts "Email Address"
  email = $stdin.gets.chomp
  puts "First Name"
  firstname = $stdin.gets.chomp
  puts "Last Name"
  lastname = $stdin.gets.chomp

  new_entry = Contact.new(firstname, lastname, email)
  new_entry.save
end

def find_id
  puts "Whose ID number are you looking for?"
  input = @stdin.gets.chomp
  results = Contact.find(id)
  puts "First name: $1"
  puts "Last name: $2"
  puts "Email: $3"
end

def find_lastname
  puts "What is the last name?"
  input = @stdin.gets.chomp
  results = Contact.find_all_by_last_name(input)
  puts "Contact:"
  puts "\n"
  results.each do |row|
    puts "Firstname: $1"
    puts "Last name: $2"
    puts "Email: $3"
    puts "/n"
  end
end

def find_firstname
  puts "What is the first name?"
  input = @stdin.gets.chomp
  results = Contact.find_all_by_first_name(input)
  puts "Contact:"
  puts "\n"
  results.each do |row|
    puts "Firstname: $1"
    puts "Last name: $2"
    puts "Email: $3"
    puts "/n"
  end
end

def find_email
  puts "What is the email address?"
  input = $stdin.gets.chomp
  results = Contact.find_by_email(input)
  puts "Here's what I could find:"
  puts "\n"
  results.each do |row|
  puts "First name: #{row["firstname"]}"
  puts "Last name: #{row["lastname"]}"
  puts "Email: #{row["email"]}"
  puts "\n"
  end
end


case command

when "test"
  puts 'this is a test'

when "help"
  puts "Here is a list of available commands:
    new  - Create a new contact
    list - List all contacts
    show - Show a contact
    find - Find a contact"

when "new"
    new_contact

when "list"
  Contact.all.each do |contact|
    puts contact.to_s
  end

when "show"
  puts "Please provide ID of the person you are looking for: "
    id = $stdin.gets.chomp
  matches = Contact.show(id)
  if matches == false
    puts "Couldn't find that ID."
  else
    matches.each do |key, value|
    puts "#{key}: #{value}."
    end
  end


when "find"
  puts "Please select your search parameters: ID, fname, lname or email: "
    term = $stdin.gets.chomp

    case input
    when "ID"
      find_id
    when "firstname"
      find_fname
    when "lastname"
      find_lname
    when "email"
      find_email
    else 
      puts "Invalid search parameters."
    end

else
  puts "Please start the app by using the 'help' command."
end





