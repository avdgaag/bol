require 'bol/version'

module Bol
  autoload :Scope,            'bol/scope'
  autoload :Configuration,    'bol/configuration'
  autoload :Product,          'bol/product'
  autoload :Query,            'bol/query'
  autoload :Request,          'bol/request'
  autoload :Requests,         'bol/requests'
  autoload :Parser,           'bol/parser'
  autoload :Parsers,          'bol/parsers'
  autoload :Proxy,            'bol/proxy'
  autoload :Category,         'bol/category'
  autoload :Refinement,       'bol/refinement'
  autoload :RefinementGroup,  'bol/refinement_group'
  autoload :Signature,        'bol/signature'

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

  def self.categories
    Scope.new.categories
  end

  def self.refinements
    Scope.new.refinements
  end

  def self.find(id)
    Product.find(id)
  end
end
