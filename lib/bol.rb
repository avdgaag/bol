require 'bol/version'

module Bol
  autoload :Category,      'bol/category'
  autoload :Configuration, 'bol/configuration'
  autoload :Product,       'bol/product'
  autoload :Query,         'bol/query'
  autoload :Request,       'bol/request'
  autoload :Requests,      'bol/requests'
  autoload :XmlParser,     'bol/xml_parser'

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure(options = nil)
    @configuration = Configuration.new(options)
    yield @configuration if options.nil?
  end

  def self.search(*args)
    Category.search(*args)
  end
end
