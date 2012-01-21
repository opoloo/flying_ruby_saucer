# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name        = 'flying_ruby_saucer'
  s.version     = '1.0.0'
  s.platform    = Gem::Platform::RUBY
  s.date        = '2012-01-21'
  s.summary     = "Hola!"
  s.description = "A simple hello world gem"
  s.authors     = ["Christian Weyer"]
  s.email       = 'cweyer@monkeyandco.de'
  s.homepage    = 'https://github.com/monkeyandco/flying_ruby_saucer'
  
  s.files        = `git ls-files`.split("\n")
  s.require_path = 'lib'
end