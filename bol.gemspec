# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'bol/version'

Gem::Specification.new do |s|
  s.name        = 'bol'
  s.version     = Bol::VERSION
  s.authors     = ['Arjan van der Gaag']
  s.email       = ['arjan@arjanvandergaag.nl']
  s.homepage    = ""
  s.summary     = %q{Simple Ruby wrapper around the bol.com developer API}
  s.description = %q{Access the bol.com product catalog from a Ruby project.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_development_dependency 'rake'
  s.add_development_dependency 'turn'
  s.add_development_dependency 'guard'
  s.add_development_dependency 'guard-minitest'
  s.add_development_dependency 'vcr'
  s.add_development_dependency 'fakeweb'
  s.add_development_dependency 'rb-fsevent'
  s.add_development_dependency 'growl'
end
