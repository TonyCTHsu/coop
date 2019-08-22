module Cran
  class Description
    def initialize(data)
      @data = data
    end

    def to_h
      {
        title: title,
        description: description,
        published_at: published_at,
        maintainer_string: maintainer_string,
        authors_string: authors_string
      }
    end

    def title
      @data.fetch('Title')
    end

    def description
      @data.fetch('Description')
    end

    def published_at
      @data.fetch('Date/Publication')
    end

    def maintainer_string
      @data.fetch('Maintainer')
    end

    def authors_string
      @data.fetch('Author')
    end
  end
end
