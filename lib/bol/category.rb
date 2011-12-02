module Bol
  class Category
    def self.search(*args)
      new(0).search(*args)
    end

    attr_reader :id

    def initialize(id = 0)
      @id = id
    end

    def +(other)
      self.class.new [*id.to_s.split('+'), *other.id.to_s.split('+')].uniq.join('+')
    end

    def -(other)
      self.class.new id.to_s.split('+').reject { |i| i == other.id.to_s }.join('+')
    end

    def search(terms)
      r = Requests::Search.new(terms, Query.new(id))
      r.query
    end

    def subcategories
      Requests::Category.new(Query.new(id))
    end

    def top
      Requests::List.new('top', Query.new(id)).query
    end
  end
end
