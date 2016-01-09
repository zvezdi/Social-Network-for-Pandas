class Panda
  attr_accessor :name , :email , :gender

  alias == eql?

  def initialize(name , email , gender)
    @name, @email, @gender = name, email, gender
  end

  def male?
    gender == 'male'
  end

  def female?
    gender == 'female'
  end

  def ==(other)
    name == other.name and 
    email == other.email and
    gender == other.gender
  end

  def to_s
    "Hello future panda friends ;). My name is #{@name} and I'm a #{@gender}.
    If you are from the other gender you can text me and send me a hot photo of you on my email: #{@email}."
  end

  def to_hash
    email.hash
  end
end