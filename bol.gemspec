# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'bol/version'

Gem::Specification.new do |s|
  s.name        = 'bol'
  s.version     = Bol::VERSION
  s.authors     = ['Arjan van der Gaag']
  s.email       = ['arjan@arjanvandergaag.nl']
  s.homepage    = "https://github.com/avdgaag/bol"
  s.summary     = %q{Simple Ruby wrapper around the bol.com developer API}
  s.description = %q{Access the bol.com product catalog from a Ruby project. You can search products, list top selling products and find product information for individual catalog items.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_dependency 'nokogiri'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'rb-fsevent'
  s.add_development_dependency 'growl'
  s.add_development_dependency 'fakeweb'
end
