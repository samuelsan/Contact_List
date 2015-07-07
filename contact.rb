require 'pg'

class Contact

  @@contacts = []
 
attr_accessor :firstname, :lastname, :email
attr_reader :id
 
  def initialize(firstname, lastname, email, id=nil)
    @firstname = firstname
    @lastname = lastname
    @email = email
    @id = id
  end

  def to_s
    return "#{@firstname}, #{@lastname}, #{@email}"
    # TODO: return string representation of Contact
  end

  #connection here
  def self.connection #refer to hero
    @conn = PG.connect( 
      dbname: 'contactlist',
      user: 'development',
      host: 'localhost',
      password: 'development'
      )
  end
 
  def save
    if @id
      #UPDATING 
      sql = "UPDATE contacts SET firstname = $1, lastname = $2, email = $3 WHERE id = $4"
      self.class.connection.exec_params(sql, [@firstname, @lastname, @email, @id])
    else 
      @id = @@conn.exec_params("INSERT INTO contacts (firstname, lastname, email)
      VALUES ($1, $2, $3) RETURNING id", [@firstname, @lastname, @email])
    # sql = "UPDATE students SET name=$1, email=$2, enrolled=$3, WHERE id = $4"
    # self.class.connection.exec_params(sql, [@name, @email, @enrolled, @id])
    end
  end

  def destroy
    @@conn.exec_params("DELETE FROM contacts WHERE id = $1", [@id])
  end

  def self.find(id)
    result = @@conn.exec_params("
      SELECT *
      FROM contacts
      WHERE id = $1", [@id])
  end

  def self.find_all_by_lastname(name)
    results = @@conn.exec_params("
      SELECT firstname, lastname, email
      FROM contacts
      WHERE lastname = $1", [@lastname])
  end


  def self.find_all_by_firstname(name)
    results = @@conn.exec_params("
      SELECT *
      FROM contacts
      WHERE firstname = $1", [@firstname])
  end

  def self.find_by_email(email)
    results = @@conn.exec_params("
      SELECT *
      FROM contacts
      WHERE email = $1", [@email])
  end
    
end

class << self
  def populate_list
    get_raw_data.each do |row|
    @@contacts << Contact.new(row[0], row[1], row[2])
    end
  end

  def create(firstname, lastname, email)
    # TODO: Will initialize a contact as well as add it to the list of contacts
    # contacts = ContactDatabase.import_csv
    # indices = contacts.length
     contact = Contact.new(firstname, lastname, email)
     contact.save
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
