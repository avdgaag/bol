module Bol
  class Configuration
    ALLOWED_KEYS = %w[key per_page].map(&:to_sym)

    def initialize(options = {})
      raise ArgumentError unless options.nil? or options.respond_to? :each_pair

      @options = { per_page: 10 }

      unless options.nil?
        options.each_pair do |k, v|
          self[k] = v
        end
      end
    end

    def [](key)
      @options[key]
    end

    def []=(key, value)
      raise ArgumentError unless ALLOWED_KEYS.include?(key)
      @options[key] = value
    end

    def method_missing(name, *args)
      return super unless respond_to? name
      if name.to_s =~ /=$/
        send(:[]=, name.to_s.sub(/=$/, '').to_sym, *args)
      else
        send(:[], name)
      end
    end

    def respond_to?(name)
      super or
        ALLOWED_KEYS.include?(name) or
        ALLOWED_KEYS.include?(name.to_s.sub(/=$/, '').to_sym)
    end
  end
end
