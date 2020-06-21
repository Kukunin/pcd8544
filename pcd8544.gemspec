# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pcd8544/version'

Gem::Specification.new do |spec|
  spec.name          = "pcd8544"
  spec.version       = Pcd8544::VERSION
  spec.authors       = ["Sergey Kukunin"]
  spec.email         = ["sergey.kukunin@gmail.com"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'http://mygemserver.com'
  end

  spec.summary       = %q{Manage PCD8544 LCD controller on Ruby}
  spec.description   = %q{The ruby library for pcd8544 LCD controller (Nokia 5110)}
  spec.homepage      = "https://github.com/Kukunin/pcd8544"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "pi_piper", "~> 2.0"
  spec.add_dependency "activesupport", "~> 4.2.1"

  spec.add_development_dependency "bundler", "~> 2.1"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.2"
end
