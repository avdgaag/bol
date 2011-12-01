require 'bol/version'

module Bol
  autoload :Category,      'bol/category'
  autoload :Configuration, 'bol/configuration'
  autoload :Product,       'bol/product'
  autoload :Query,         'bol/query'
  autoload :Request,       'bol/request'
  autoload :Requests,      'bol/requests'

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure(options = nil)
    @configuration = Configuration.new(options)
    yield @configuration if options.nil?
  end
end
