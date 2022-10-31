class Nameable
  def correct_name
    raise NotImplementedError, 'Not Implemented'
  end
end

class Person < Nameable
  def initialize(age, name)
    super()
    @age = age
    @name = name
  end

  def correct_name
    @name
  end
end

class Decorator < Nameable
  def initialize(nameable)
    super()
    @nameable = nameable
  end

  def correct_name
    @nameable.correct_name
  end
end

class CapitalizeDecorator < Decorator
  def correct_name
    @nameable.correct_name.capitalize
  end
end

class TrimmerDecorator < Decorator
  def correct_name
    str = @nameable.correct_name
    str.length > 10 ? str[0...10] : str
  end
end
