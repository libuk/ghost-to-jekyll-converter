require 'kramdown'

module GhostToJekyll
  class Converter
    attr_reader :html, :post_title

    def initialize(html:, post_title:)
      @html = html
      @post_title = post_title
    end

    def convert
      front_matter + convert_html_to_kramdown
    end

    private

    def convert_html_to_kramdown
      Kramdown::Document.new(html, { :html_to_native => true, :auto_ids => false }).to_kramdown
    end

    def front_matter
      "---\ntitle: #{post_title}\n---\n\n"
    end
  end
end

