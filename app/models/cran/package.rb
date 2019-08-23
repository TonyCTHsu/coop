module Cran
  class Package
    def initialize(data)
      @data = data
    end

    def to_h
      {
        name: name,
        version: version
      }
    end

    private

    def name
      @data.fetch('Package')
    end

    def version
      @data.fetch('Version')
    end
  end
end
