#we need different objects for the different formats
#each of which is able to save and to load file

#require 'nokogiri' # for xml

class JsonSerializer
  def initialize(object)
    @object = object
  end

	def save(file_name)
		begin
      file = File.open(file_name, "w")
      file.write(@object.to_json)
    rescue IOError => e
      #some error occur, dir not writable etc.
    ensure
      file.close unless file.nil?
    end
	end

  def load(file_name)
    content = File.read file_name
    JSON.parse content
  end
end

