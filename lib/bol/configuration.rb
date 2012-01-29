module Bol
  ConfigurationError = Class.new(Exception)

  class Configuration
    ALLOWED_KEYS = %w[access_key secret per_page].map(&:to_sym)
    REQUIRED_KEYS = %w[access_key secret].map(&:to_sym)

    def initialize(options = {})
      unless options.nil? || options.respond_to?(:each_pair)
        raise ArgumentError, 'options should be Hash-like object'
      end

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
      unless ALLOWED_KEYS.include?(key)
        raise ArgumentError, "#{key} is not a valid key"
      end

      @options[key] = value
    end

    def validate
      REQUIRED_KEYS.each { |key| @options.fetch(key) }
    rescue KeyError
      raise Bol::ConfigurationError
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
