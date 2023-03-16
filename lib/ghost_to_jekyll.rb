require 'fileutils'
require_relative 'ghost_to_jekyll/converter'
require_relative 'ghost_to_jekyll/ghost_post'
require_relative 'ghost_to_jekyll/jekyll_formatter'
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
        ghost_post = GhostPost.new(post)

        next unless ghost_post.html && ghost_post.published?

        title = ghost_post.title

        p "processing post: #{title}"

        file_path = converted_file_path(formatter(ghost_post).post_filename)
        data = kramdown(html: ghost_post.html, title: ghost_post.title)

        begin
          File.open(file_path, 'w') do |file|
            file.write(data)
          end
        rescue IOError => e
          puts e
          exit
        end

        p "File created #{@converted_file_path}"
      end
    end

    def kramdown(html:, title:)
      @kramdown = Converter.new(html: html, post_title: title).convert
    end

    def formatter(post)
      @formatter = JekyllFormatter.new(date: post.published_at, slug: post.slug)
    end

    def create_dir
      @converted_post_dir = "#{Dir.home}/ghost-to-jekyll/converted_posts"

      FileUtils.remove_dir(@converted_post_dir, force: true)
      FileUtils.mkdir_p(@converted_post_dir)
    end

    def converted_file_path(filename)
      @converted_file_path = "#{@converted_post_dir}/#{filename}"
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

