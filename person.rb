require './rental'

class Person
  attr_reader :id, :rentals
  attr_accessor :name, :age

  def initialize(age, name = 'Unknown', parent_permission: true)
    @id = Random.rand(1..100)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  # rubocop:disable Naming/PredicateName
  def is_of_age?
    @age >= 18
  end
  # rubocop:enable Naming/PredicateName

  private :is_of_age?

  def can_use_services?
    true if is_of_age? || @parent_permission
  end

  def add_rental(date, book)
    Rental.new(date, book, self)
  end
end
