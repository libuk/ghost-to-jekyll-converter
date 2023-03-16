require 'json'

module GhostToJekyll
  class JSONParser
    attr_reader :json_file

    def initialize(json_file)
      @json_file = json_file
    end

    def parse!
      if file_exists?
        begin
          parse_json!
        rescue JSON::ParserError
          raise JSON::ParserError,'Unable to parse JSON file, please ensure JSON is valid.'
        end
      else
        raise IOError, "Unable to find file #{json_file}. Please specify a valid file path." 
      end
    end

    private

    def file_exists?
      File.exists?(json_file)
    end

    def parse_json!
      file = File.open(json_file)

      JSON.parse(file.read, symbolize_names: true)
    end
  end
end
