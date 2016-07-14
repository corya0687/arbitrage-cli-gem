# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'arbitrage/version'

Gem::Specification.new do |spec|
  spec.name          = "arbitrage"
  spec.version       = Arbitrage::VERSION
  spec.authors       = ["corya0687"]
  spec.email         = ["corya0687@gmail.com"]

  spec.summary       = %q{Finds profit opportunity on Craigslist}
  spec.description   = %q{CLI Gem that compares the price of a product in your local craigslist market to ones neaby and returns a potential profit report}
  spec.homepage      = "https://github.com/corya0687/arbitrage-cli-gem.git"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = ["arbitrage"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry","~> 0"
  spec.add_runtime_dependency "bundler", "~> 1.11"
  spec.add_runtime_dependency "require_all"


end
