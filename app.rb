require_relative './student'
require_relative './teacher'
require_relative './book'

class App
  def initialize
    @people = []
    @books = []
    @rentals = []
  end

  def welcome_message
    puts
    puts "Welcome to School Library App! #{Time.now}"
    puts
  end

  def message
    puts
    puts "Please choose an option by entering a number:
	1 - List all books
	2 - List all people
	3 - Create a person
	4 - Create a book
	5 - Create a rental
	6 - List all rentals for a given person id
	7 - Exit
	"
  end

  # rubocop:disable Metrics/CyclomaticComplexity
  def logic
    number = gets.chomp.to_i
    case number
    when 1
      list_all_books
    when 2
      list_all_people
    when 3
      create_person
    when 4
      create_book
    when 5
      create_rental
    when 6
      list_rentals
    when 7
      abort('Thank you for using this App!')
    else
      abort('Wrong Input Range [1..7]')
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity

  def create_person
    print 'Select 1 for Student 2 for Teacher: '
    input = gets.chomp.to_i
    inputs = helper_func_create_person(['Age: ', 'Name: ',
                                        if input == 1
                                          'Classroom (select A for section-A, B for section-B etc): '
                                        else
                                          'Specialization: '
                                        end])
    person = if input == 1
               Student.new(inputs[0], inputs[2],
                           inputs[1])
             else
               Teacher.new(inputs[0], inputs[2], inputs[1])
             end
    @people.push(person)
    print input == 1 ? 'Book created succesfully' : 'Teacher created succesfully'
    message
    logic
  end

  def helper_func_create_person(array)
    outputs = []
    array.each_with_index do |elem, idx|
      print elem
      outputs.push(idx.zero? ? gets.chomp.to_i : gets.chomp)
    end
    outputs
  end

  def create_book
    inputs = helper_func_take_inputs_create_book(['Title: ', 'Author: '])
    book = Book.new(inputs[0], inputs[1])
    @books.push(book)
    print 'Book created succesfully'
    message
    logic
  end

  def helper_func_take_inputs_create_book(parameters)
    outputs = []
    parameters.each do |s|
      print s
      outputs.push(gets.chomp)
    end
    outputs
  end

  def create_rental
    inputs = helper_func_take_book_inputs_create_rentals(['Select a book from the following list by S.No: ',
                                                          'Select a person from the following list by S.No (not ID): '])
    date = Time.now.strftime('%Y/%m/%d')
    rental_created = Rental.new(date, @books[inputs[0] - 1], @people[inputs[1] - 1])
    @rentals.push(rental_created)
    print 'Retnal created succesfully'
    message
    logic
  end

  def helper_func_take_book_inputs_create_rentals(parameters)
    outputs = []
    parameters.each_with_index do |s, idx|
      print s
      puts
      idx.zero? ? helper_func_list_all_books : helper_func_list_all_people
      outputs.push(gets.chomp.to_i)
    end
    outputs
  end

  def list_all_people
    helper_func_list_all_people
    message
    logic
  end

  def helper_func_list_all_people
    @people.each_with_index do |person, idx|
      puts "S.No: #{idx + 1} | [#{person.type}] | Name: #{person.name} | ID: #{person.id} | Age: #{person.age}"
    end
  end

  def list_all_books
    helper_func_list_all_books
    message
    logic
  end

  def helper_func_list_all_books
    @books.each_with_index { |book, idx| puts "S.No: #{idx + 1} | Title: #{book.title} By Author: #{book.author}" }
  end

  def list_rentals
    print 'the following persons have rented books, Select id of the person'
    puts
    @rentals.each { |object| puts "#{object.person.id} | #{object.person.name}" }
    person_id = gets.chomp.to_i
    @rentals.each do |object|
      if object.person.id == person_id
        puts "Date: #{object.date}, Book \"#{object.book.title}\" by #{object.book.author}"
      end
    end
    message
    logic
  end
end
