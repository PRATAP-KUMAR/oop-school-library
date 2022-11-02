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
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]:'
    input = gets.chomp.to_i
    case input
    when 1
      helper_func_create_student
    when 2
      helper_func_create_teacher
    end
  end

  def helper_func_create_student
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    print 'Classroom (example A for section-A, B for section-B): '
    classroom = gets.chomp
    student = Student.new(age, classroom, name)
    @people.push(student)
    print 'Person created succesfully'
    print
    message
    logic
  end

  def helper_func_create_teacher
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    print 'Specialization: '
    spec = gets.chomp
    teacher = Teacher.new(age, spec, name)
    @people.push(teacher)
    print 'Person created successfully'
    message
    logic
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    book = Book.new(title, author)
    @books.push(book)
    print 'Book created succesfully'
    message
    logic
  end

  def create_rental
    print 'Select a book from the following list by S.No'
    puts
    helper_func_list_all_books
    book_input = gets.chomp.to_i
    print 'Select a person from the following list by S.No (not id)'
    puts
    helper_func_list_all_people
    person_input = gets.chomp.to_i
    date = Time.now.strftime('%Y/%m/%d')
    rental_created = Rental.new(date, @books[book_input - 1], @people[person_input - 1])
    @rentals.push(rental_created)
    print 'Retnal created succesfully'
    message
    logic
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
