# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mlbschedule/version'

Gem::Specification.new do |gem|
  gem.name          = "mlbschedule"
  gem.version       = Mlbschedule::VERSION
  gem.authors       = ["Christian Frugard"]
  gem.email         = ["frugardc@gmail.com"]
  gem.description   = %q{MLB Schedule Gem}
  gem.summary       = %q{Interface to the MLB Schedule on the mlb site.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
