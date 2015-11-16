# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cliprompt/version'

Gem::Specification.new do |spec|
  spec.name          = "cliprompt"
  spec.version       = Cliprompt::VERSION
  spec.authors       = ["mose"]
  spec.email         = ["mose@mose.com"]
  spec.summary       = %q{Env aware lib for CLI prompt.}
  spec.description   = %q{This library provides a simple DSL for managing user interaction in a CLI application.}
  spec.homepage      = "https://github.com/mose/cliprompt"
  spec.license       = "MIT"

  spec.files         = %w(
                        lib/cliprompt.rb
                        lib/cliprompt/optionset.rb
                        lib/cliprompt/version.rb
                        README.md
                        LICENSE
                        )
  spec.executables   = []
  spec.test_files    = %w(
                        spec/spec_helper.rb
                        spec/lib/cliprompt_spec.rb
                        spec/lib/cliprompt/optionset_spec.rb
                        )
  spec.require_paths = ["lib"]

  spec.add_dependency 'paint'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec', "~> 3.0"
  spec.add_development_dependency 'rspec-given'
  spec.add_development_dependency 'codeclimate-test-reporter'
end
