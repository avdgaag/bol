module Bol
  class Query
    attr_reader :category_id
    attr_accessor :request

    def initialize(category_id)
      raise ArgumentError unless category_id.is_a?(Fixnum)
      @category_id = category_id
    end

    def params
      p = {
        categoryId: @category_id,
      }
      p[:nrProducts]       = @limit           if @limit
      p[:offset]           = @offset          if @offset
      p[:sortingMethod]    = @order_key       if @order_key
      p[:sortingAscending] = @order_direction if @order_direction
      p[:term]             = @term            if @term
      p
    end

    def has_param?(key)
      params.has_key?(key) and !params[key].nil?
    end

    def search(term = nil)
      return @term if term.nil?
      @term = term
      self
    end

    def order(str)
      if str =~ /^(sales_ranking|price|title|publishing_date|customer_rating) (ASC|DESC)/
        @order_key = $1
        @order_direction = $2 == 'ASC' ? 'true' : 'false'
      else
        raise ArgumentError
      end
      self
    end

    def page(n = nil)
      limit Bol.configuration[:per_page]
      offset ((n || 1).to_i - 1) * Bol.configuration[:per_page]
      self
    end

    def offset(n = nil)
      return @offset if n.nil?
      @offset = n.to_i
      self
    end

    def limit(n = nil)
      return @limit if n.nil?
      @limit = n.to_i
      self
    end
  end
end
