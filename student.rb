require './person'

class Student < Person
  def initialize(classroom)
    super(18)
    @classroom = classroom
  end

  def play_hooky
    '¯(ツ)/¯'
  end
end
