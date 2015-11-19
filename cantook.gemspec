# Maintain your gem's version:
require "cantook/version"

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "cantook"
  spec.version       = Cantook::VERSION
  spec.authors       = ["Gordon B. Isnor"]
  spec.email         = ["gordonbisnor@gmail.com"]
  spec.description   = %q{Cantook gem}
  spec.summary       = %q{Facilitates Ruby and Ruby on Rails interactions with the Cantook API}
  spec.homepage      = "http://www.github.com/gordonbisnor/cantook"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency('httparty')

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
