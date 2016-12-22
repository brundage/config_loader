# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'config_loader/version'

Gem::Specification.new do |spec|
  spec.name          = "config_loader"
  spec.version       = ConfigLoader.version
  spec.authors       = ["Dean Brundage"]
  spec.email         = ["dean@deanandadie.net"]

  spec.summary       = %q{A loader for configs}
  spec.description   = %q{Utility class to load YAML config files}
  spec.homepage      = "https://github.com/brundage/config_loader"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "coveralls"

end
