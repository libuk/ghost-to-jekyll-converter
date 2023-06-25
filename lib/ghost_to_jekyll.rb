require 'fileutils'
require 'date'
require_relative 'ghost_to_jekyll/converter'
require_relative 'ghost_to_jekyll/json_parser'

module GhostToJekyll
  class GhostToJekyll
    attr_reader :config

    def initialize(config)
      @config = config
    end

    def file_not_supplied?
      config[:file].nil?
    end

    def convert
      parse_json

      create_dir

      convert_posts
    end

    private

    def convert_posts
      posts.each do |post|
        next unless post[:html] && post[:status] == 'published'

        p "processing post: #{post[:title]}"

        formatted_date = DateTime.parse(post[:published_at]).strftime('%Y-%m-%d')
        filename = "#{formatted_date}-#{post[:slug]}.md"
        file_path = "#{@converted_post_dir}/#{filename}"

        data = Converter.new(html: post[:html], post_title: post[:title]).convert

        begin
          File.open(file_path, 'w') do |file|
            file.write(data)
          end
        rescue IOError => e
          puts e
          exit
        end

        p "File created #{file_path}"
      end
    end

    def create_dir
      @converted_post_dir = "#{Dir.home}/ghost-to-jekyll/converted_posts"

      FileUtils.remove_dir(@converted_post_dir, force: true)
      FileUtils.mkdir_p(@converted_post_dir)
    end

    def posts
      @json[:db][0][:data][:posts]
    end

    def json_file_path
      config[:file]
    end

    def parse_json
      parser = JSONParser.new(json_file_path)

      begin
        @json = parser.parse!
      rescue StandardError => error
        puts error
        exit
      end
    end
  end
end

