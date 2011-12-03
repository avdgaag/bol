module Bol
  class ResultProxy
    include Enumerable

    attr_reader :request

    def initialize(request)
      @request = request
    end

    def product
      @product ||= parser.product
    end

    def all
      @all ||= parser.products
    end

    def each
      @all.each { |a| yield a }
    end

    %w[category_id= category_id].each do |method|
      define_method method do |*args|
        request.query.send method, *args
      end
    end

    %w[order page offset limit].each do |method|
      define_method method do |*args|
        request.query.send method, *args
        self
      end
    end

  private

    def parser
      @parser ||= XmlParser.new(request.fetch.body)
    end
  end
end
