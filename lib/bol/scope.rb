module Bol
  class Scope
    attr_reader :ids

    def initialize(ids = nil)
      @ids = Array(ids)
      @ids = [0] if @ids.empty?
    end

    def to_s
      ids.join('+')
    end

    def +(other)
      self.class.new((ids + other.ids).uniq)
    end

    def -(other)
      self.class.new(ids - other.ids)
    end

    def search(terms)
      q = Query.new(to_s)
      q.search terms
      Requests::Search.new(q).proxy
    end

    def categories
      q = Query.new(to_s)
      q.include :categories
      Requests::List.new('toplist_default', q).proxy
    end

    def refinements
      q = Query.new(to_s)
      q.include :refinements
      Requests::List.new('toplist_default', q).proxy
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
        q = Query.new(to_s)
        q.include :products
        Requests::List.new(type, q).proxy
      end
    end
  end
end
