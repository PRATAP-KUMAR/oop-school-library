require './person'

class Student < Person
  attr_reader	:classroom, :type

  def initialize(age, classroom, name = 'Unknown')
    super(age, name)
    @classroom = classroom
    @type = 'Student'
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end

  def play_hooky
    '¯(ツ)/¯'
  end
end
