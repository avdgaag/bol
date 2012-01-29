require 'bol/version'

module Bol
  autoload :Scope,         'bol/scope'
  autoload :Configuration, 'bol/configuration'
  autoload :Product,       'bol/product'
  autoload :Query,         'bol/query'
  autoload :Request,       'bol/request'
  autoload :Requests,      'bol/requests'
  autoload :XmlParser,     'bol/xml_parser'
  autoload :ResultProxy,   'bol/result_proxy'

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset_configuration
    @configuration = nil
  end

  def self.configure(options = nil)
    @configuration = Configuration.new(options)
    yield @configuration if options.nil?
  end

  def self.search(*args)
    Scope.new.search(*args)
  end
end
