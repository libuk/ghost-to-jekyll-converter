module GhostToJekyll
  class GhostPost
    attr_reader :post

    def initialize(post)
      @post = post
    end

    def title
      @title ||= post[:title]
    end

    def published_at
      @published_at ||= post[:published_at]
    end

    def status
      @status ||= post[:status]
    end

    def slug
      @slug ||= post[:slug]
    end

    def html
      @html ||= post[:html]
    end

    def published?
      status == 'published'
    end
  end
end

