# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'exonio/version'

Gem::Specification.new do |spec|
  spec.name          = "exonio"
  spec.version       = Exonio::VERSION
  spec.authors       = ["Rafael Izidoro"]
  spec.email         = ["izidoro.rafa@gmail.com"]

  spec.summary       = %q{Excel usefull formulas written in Ruby}
  spec.description   = %q{This gem implements some useful Excel formulas like PMT, IPMT, NPER, PV, etc...}
  spec.homepage      = "http://github.com/noverde/exonio"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry-byebug", "~> 3.10.1"
end
