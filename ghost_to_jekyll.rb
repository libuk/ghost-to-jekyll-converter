require 'json'
require 'kramdown'

BACKUP_FILE_PATH='./backup.json'

exit 1 unless File.exists?(BACKUP_FILE_PATH)

file = File.new(BACKUP_FILE_PATH)
json = JSON.parse(file.read, symbolize_names: true)

ghost_version = json[:db][0][:meta][:version]

posts = json[:db][0][:data][:posts]

document = Kramdown::Document.new(posts[0][:html], { :html_to_native => true, :auto_ids => false })

