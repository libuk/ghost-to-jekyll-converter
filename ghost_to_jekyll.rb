require 'json'
require 'kramdown'
require 'date'

# Retrieve the JSON
#
# Usage:
# Providing a JSON file - ruby ghost_to_jekyll.rb --file backup.json
#

@options = {}
@next_arg = nil

ARGV.each do |arg|
  case arg
  when '--file', '-f'
    @next_arg = :file
  else
    if @next_arg
      @options[@next_arg] = arg
    end
    @next_arg = nil
  end
end

# Exit if file isn't provided
if !@options[:file]
  p 'please specify a file'
  exit
end

# Exit if file doesn't exist
file_path = "./#{@options[:file]}"

if !File.exists?(file_path)
  p "Unable to find file #{file_path}. Please specify a valid file path"
  exit
end

# Parse JSON
p "Processing file: #{file_path}"

file = File.open(file_path)

json = nil

begin
  json = JSON.parse(file.read, symbolize_names: true)
rescue JSON::ParserError
  p 'Unable to parse JSON file, please ensure JSON is valid.'
  exit
end

# Get ghost data
ghost_data = json[:db][0]

ghost_version = ghost_data[:meta][:version]
p "Detected Ghost version: #{ghost_version}"

# Create directory
converted_post_dir = 'converted_posts'

Dir.mkdir(converted_post_dir)

# Convert posts
posts = ghost_data[:data][:posts]

posts.each do |post|
  next if !post[:html] || post[:status] != 'published'

  p "processing post: #{post[:title]}"

  document_html = Kramdown::Document.new(post[:html], { :html_to_native => true, :auto_ids => false })

  post_published_date = DateTime.parse(post[:published_at])
  converted_post_filename = "#{post_published_date.strftime('%Y-%m-%d')}-#{post[:slug]}.md"
  converted_file_path = "./#{converted_post_dir}/#{converted_post_filename}"

  begin
    File.open(converted_file_path, 'w') do |file|
      file.write(document_html.to_kramdown)
    end
  rescue IOError => e
    puts e
  end

  p "File created #{converted_file_path}"
end

