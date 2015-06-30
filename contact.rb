class Contact

  @@contacts = []
 
  attr_accessor :name, :email, :phone_number
 
  def initialize(name, email, phone_number)
    @name = name
    @email = email
    @phone_number = phone_number
  end
 
  def to_s
    return "#{@name}, #{@email}, #{@phone_number}"
    # TODO: return string representation of Contact
  end
 
  ## Class Methods
  class << self

    def populate_list
      get_raw_data.each do |row|
      @@contacts << Contact.new(row[0], row[1], row[2])
      end
    end

     def create(name, email, phone_number)
      @@contacts.each do |x|
        if x.email == email
          puts "Email '#{email}' already exists"
          return
        end
      end
      @@contacts << Contact.new("name", "email", "phone_number")
    end 

 def find(term)
      match = []
      @@contacts.collect do |x|
        match << x if (x.name.include? term) || (x.email.include? term)
      end 
      return match
    end
 
       def all
      return @@contacts.each do |x|
        x.to_s
      end
    end
    
    def show(id)
      # TODO: Show a contact, based on ID
      # TODO: non-int's shouldn't return first item in array
      return @@contacts[id.to_i] if @@contacts[id.to_i]
      puts "Not Found"
    end
  end
end

