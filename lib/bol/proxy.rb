module Bol
  class Proxy
    include Enumerable

    attr_reader :request, :parser

    def initialize(request, parser)
      @request = request
      @parser  = parser
    end

    def each
      all.each { |a| yield a }
    end

    def all
      @all ||= parser.objects
    end

    def query
      request.query
    end

    %w[category_id= category_id].each do |method|
      define_method method do |*args|
        query.send method, *args
      end
    end

    %w[order page offset limit].each do |method|
      define_method method do |*args|
        query.send method, *args
        self
      end
    end
  end
end
