require './book'
require './person'

class Rental
  attr_accessor :date
  attr_reader :book, :person

  def initialize(date, book, person)
    @date = date
    @person = person
    person.rentals << self

    @book = book
    book.rentals << self
  end
end
