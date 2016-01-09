require 'minitest/autorun'
require_relative 'panda'
require_relative 'social_network'

class PandaTest < Minitest::Test
  def test_panda_to_s
    p = Panda.new("Ivo", "ivo@pandamail.com", "male")
    expected = "Hello future panda friends ;). My name is Ivo and I'm a male.
    If you are from the other gender you can text me and send me a hot photo of you on my email: ivo@pandamail.com."
    assert_equal expected, p.to_s
  end

  def test_if_panda_is_male
    p = Panda.new("Ivo", "ivo@pandamail.com", "male")
    assert_equal true, p.male?
  end
  
  def test_if_panda_is_female
    p = Panda.new("Ivo", "ivo@pandamail.com", "male")
    assert_equal false, p.female?
  end
  
  def test_if_the_name_of_panda_is_true #what does it mean for the name to be true?
    p = Panda.new("Ivo", "ivo@pandamail.com", "male")
    assert_equal true, p.name == 'Ivo'
  end
  
  def test_if_the_email_of_panda_is_true
    p = Panda.new("Ivo", "ivo@pandamail.com", "male")
    assert_equal true, p.email == 'ivo@pandamail.com'
  end
end

class PandaSocialNetworkTest < Minitest::Test
  def test_if_two_pandas_are_friends
    network = PandaSocialNetwork.new
    ivo = Panda.new("Ivo", "ivo@pandamail.com", "male")
    rado = Panda.new("Rado", "rado@pandamail.com", "male")
    network.add_panda(ivo)
    network.add_panda(rado)

    network.make_friends(ivo, rado)

    assert_equal true, network.are_friends?(ivo, rado) 
  end

  def test_the_connection_level_of_two_pandas
    network = PandaSocialNetwork.new
    ivo = Panda.new("Ivo", "ivo@pandamail.com", "male")
    rado = Panda.new("Rado", "rado@pandamail.com", "male")
    network.add_panda(ivo)
    network.add_panda(rado)

    network.make_friends(ivo, rado)

    assert_equal 1, network.connection_level(ivo, rado)
  end

  def test_the_connection_level_of_pandas_who_are_not_friends
    network = PandaSocialNetwork.new
    ivo = Panda.new("Ivo", "ivo@pandamail.com", "male")
    rado = Panda.new("Rado", "rado@pandamail.com", "male")
    tony = Panda.new("Tony", "tony@pandamail.com", "female")

    network.add_panda(ivo)
    network.add_panda(rado)
    network.add_panda(tony)

    network.make_friends(ivo, rado)
    network.make_friends(rado, tony)

    assert_equal 2, network.connection_level(ivo, tony)
  end

  def test_if_a_panda_is_a_member_of_network
    network = PandaSocialNetwork.new
    zvezdi = Panda.new("Zvezdelina", "zvezdi@pandamail.com", "female")

    network.add_panda(zvezdi)

    assert_equal true, network.has_panda?(zvezdi)
  end

  # def test_for_error_when_panda_is_already_in_the_network
  #   network = PandaSocialNetwork.new
  #   zvezdi = Panda.new("Zvezdelina", "zvezdi@pandamail.com", "female")

  #   network.add_panda(zvezdi)
    
  #   assert_raise_with_message('PandaAlreadyThere', network.add_panda(zvezdi))
  # end

  # def test_for_error_if_two_pandas_are_already_friends
  #   network = PandaSocialNetwork.new
  #   ivo = Panda.new("Ivo", "ivo@pandamail.com", "male")
  #   rado = Panda.new("Rado", "rado@pandamail.com", "male")
  #   network.add_panda(ivo)
  #   network.add_panda(rado)

  #   network.make_friends(ivo, rado)
  #   expected = Exception.new 'PandasAlreadyFriends'

  #   assert_equal expected, network.make_friends(ivo, rado)
  # end

  def test_for_gender_of_friends_of_panda
    network = PandaSocialNetwork.new
    rado = Panda.new("Rado", "rado@pandamail.com", "male")
    tony = Panda.new("Tony", "tony@pandamail.com", "female")

    network.make_friends(rado, tony)

    assert_equal 1, network.how_many_gender_in_network(1, rado, "female")
  end
end