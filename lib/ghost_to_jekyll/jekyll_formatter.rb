require 'date'

module GhostToJekyll
  class JekyllFormatter
    attr_reader :date, :slug

    def initialize(date:, slug:)
      @date = date
      @slug = slug
    end

    def post_filename
      "#{formatted_date}-#{slug}.md"
    end

    private

    def formatted_date
      DateTime.parse(date).strftime('%Y-%m-%d')
    end
  end
end
