module Bol
  class Category
    def self.search(*args)
      new(0).search(*args)
    end

    attr_reader :id

    def initialize(id = 0)
      @id = id
    end

    def search(terms)
      request = Requests::Search.new(Query.new(id, terms)).query
    end

    def subcategories
      Requests::Category.new(Query.new(id))
    end

    def top
      Requests::List.new(Query.new(id)).query
    end
  end
end
