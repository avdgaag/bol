module Bol
  class Product
    def self.find(id)
      Requests::Product.new(id, Query.new(0)).proxy.product
    end

    attr_reader :attributes

    def initialize
      @attributes = {}
    end

    def [](key)
      @attributes[key]
    end

    def []=(key, value)
      @attributes[key] = value
    end

    def cover(kind = :medium)
      attributes[:cover].fetch(kind)
    end

    def method_missing(name, *args)
      if attributes.keys.include?(name)
        if name =~ /=$/
          attributes[name] = *args
        else
          attributes[name]
        end
      else
        super
      end
    end

    def respond_to?(name)
      super or attributes.keys.include?(name) or
        attributes.keys.include?(name.to_s.sub(/=$/, '').to_sym)
    end
  end
end
