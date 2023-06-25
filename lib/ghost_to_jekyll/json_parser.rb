require 'json'

module GhostToJekyll
  class JSONParser
    attr_reader :json_file

    def initialize(json_file)
      @json_file = json_file
    end

    def parse!
      if File.exists?(json_file)
        begin
          file = File.open(json_file)

          JSON.parse(file.read, symbolize_names: true)
        rescue JSON::ParserError
          raise JSON::ParserError,'Unable to parse JSON file, please ensure JSON is valid.'
        end
      else
        raise IOError, "Unable to find file #{json_file}. Please specify a valid file path." 
      end
    end
  end
end
