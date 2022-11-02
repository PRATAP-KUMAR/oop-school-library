require './person'

class Teacher < Person
  attr_reader	:type

  def initialize(age, specialization, name = 'Unknown')
    super(age, name)
    @specialization = specialization
    @type = 'Teacher'
  end

  def can_use_services?
    true
  end
end
