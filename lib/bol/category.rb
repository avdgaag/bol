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

    {
      top_products: 'toplist_default',
      top_products_overall: 'toplist_overall',
      top_products_last_week: 'toplist_last_week',
      top_products_last_two_months: 'toplist_last_two_months',
      new_products: 'new',
      preorder_products: 'preorder'
    }.each_pair do |method, type|
      define_method method do
        Requests::List.new(type, Query.new(id)).proxy
      end
    end
  end
end
