# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'travis_report/version'

Gem::Specification.new do |spec|
  spec.name          = TravisReport::PROJECT
  spec.version       = TravisReport::VERSION
  spec.authors       = ["dkhamsing"]
  spec.email         = ["dkhamsing8@gmail.com"]

  spec.summary       = TravisReport::PROJECT_DESCRIPTION
  spec.description   = TravisReport::PROJECT_DESCRIPTION
  spec.homepage      = TravisReport::PROJECT_URL
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = [TravisReport::PROJECT]
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'travis', '~> 1.8.2'
  spec.add_runtime_dependency 'parallel', '~> 1.6.1'
end
