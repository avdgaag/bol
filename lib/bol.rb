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

  class ApiError < StandardError; end
  class NotFound < ApiError; end
  class Unavailable < ApiError; end

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

  class << self
    %w{
      top_products
      top_products_overall
      top_products_last_week
      top_products_last_two_months
      new_products
      preorder_products
      search
      categories
      refinements
    }.each do |name|
      define_method name do |*args|
        Scope.new.send(name, *args)
      end
    end
  end

  def find(id)
    Bol::Product.find(id)
  end
end
