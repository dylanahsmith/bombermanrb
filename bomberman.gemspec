# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bomberman/version'

Gem::Specification.new do |spec|
  spec.name          = "bomberman"
  spec.version       = Bomberman::VERSION
  spec.authors       = ["Dylan Thacker-Smith"]
  spec.email         = ["Dylan.Smith@shopify.com"]
  spec.summary       = "Bomberman Client"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'curses', '~> 1.0.1'
  spec.add_dependency 'oj', '~> 2.0.10'
  spec.add_dependency 'multi_json', '~> 1.9.2'
end
