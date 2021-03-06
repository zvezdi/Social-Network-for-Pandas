require 'json'
require_relative 'panda'
require_relative 'savers_and_loaders'

class PandaSocialNetwork
  def self.load(filename, format)
    load_class = format.new(self)
    social_network = load_class.load(filename)

    PandaSocialNetwork.new social_network
  end

  attr_accessor :social_network

  def initialize(social_network = {})
    @social_network = social_network
  end

  def save(file_name, format)
    saver = format.new(self)
    saver.save(file_name)
  end

  def to_json
    social_network.to_json
  end

  def add_panda(panda)
    if social_network.member? panda
      raise 'PandaAlreadyThere'
    else
      social_network[panda] = []
    end
  end

  def has_panda?(panda)
    social_network.member? panda
  end

  def make_friends(panda1, panda2)
    raise 'PandasAlreadyFriends' if are_friends? panda1, panda2

    add_panda panda1 unless has_panda? panda1
    add_panda panda2 unless has_panda? panda2

    social_network[panda1] << panda2
    social_network[panda2] << panda1
  end

  def are_friends?(panda1, panda2)
    return false unless has_panda? panda1 or has_panda? panda2
    friends_of(panda1).include? panda2
  end

  def friends_of(panda)
    return false unless has_panda? panda 
    social_network[panda]
  end

  def connection_level(panda1, panda2)
    return false unless has_panda? panda1 and has_panda? panda2
    find_distance(panda1, panda2)
  end

  def are_connected?(panda1, panda2)
    return false unless has_panda? panda1 and has_panda? panda2
    find_distance(panda1, panda2) > 0
  end

  def how_many_gender_in_network(level, panda, gender)
    count_gender = 0
    next_level = friends_of(panda)

    level.times do
      current_level = next_level
      next_level = []

      current_level.each do |pandichka| 
        count_gender += 1 if pandichka.gender == gender
        next_level << friends_of(pandichka)
      end

      next_level = next_level.flatten
    end

   count_gender 
  end

  def to_s
    social_network.to_s
  end

#-------------------------------------#

  private

  def find_distance(panda1, panda2) # wannabe bfs
    queue = [[panda1]]
    visited = []
    depth = 1

    until queue.empty?
      current_panda = queue[0].shift

      visited << current_panda
      return depth if are_friends? current_panda, panda2

      next_level = friends_of(current_panda).reject do |panda| 
        visited.include? panda or queue.flatten.include? panda
      end
      queue << next_level unless next_level.empty?
      
      #prepare next
      if queue[0].empty?
        queue.shift
        depth += 1
      end
    end

    -1
  end
end


net = PandaSocialNetwork.new
ani = Panda.new "Ani", "ani@panda.net", "male"
net.add_panda ani
net.save("data/database", JsonSerializer)

second = PandaSocialNetwork.load("data/database", JsonSerializer)
second.save("data/checkload", JsonSerializer)