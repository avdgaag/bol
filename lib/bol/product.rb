require 'cgi'

module Bol
  class Product
    def self.find(id)
      Requests::Product.new(id, Query.new(0)).proxy.all.first
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

    def referral_url(site_id)
      format = "http://partnerprogramma.bol.com/click/click?p=1&t=url&s=%s&url=%s&f=API&subid=%s&name=%s"
      format % [
        site_id,
        attributes.fetch(:url),
        attributes.fetch(:id),
        attributes.fetch(:title),
      ].map { |p| CGI.escape(p) }
    end

    def method_missing(name, *args)
      return super unless attributes.keys.include?(name)
      if name =~ /=$/
        attributes[name] = *args
      else
        attributes[name]
      end
    end

    def respond_to?(name)
      super or attributes.keys.include?(name) or
        attributes.keys.include?(name.to_s.sub(/=$/, '').to_sym)
    end
  end
end
