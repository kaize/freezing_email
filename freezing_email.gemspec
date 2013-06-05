# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'freezing_email/version'

Gem::Specification.new do |spec|
  spec.name          = "freezing_email"
  spec.version       = FreezingEmail::VERSION
  spec.authors       = ["Andrew8xx8"]
  spec.email         = ["avk@8xx8.ru"]
  spec.description   = %q{Saving emais from your Rails app and view it later}
  spec.summary       = %q{Saving emais from your Rails app and view it later}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "slim", ">= 1.1.0"
  spec.add_runtime_dependency "sinatra"
  spec.add_runtime_dependency "rails", "~> 3.2.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.6"
  spec.add_development_dependency "cucumber", "~> 1.0.0"
  spec.add_development_dependency "aruba"
end
