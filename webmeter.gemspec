# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "webmeter/version"

Gem::Specification.new do |s|
  s.name        = "webmeter"
  s.version     = Webmeter::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Adrian Dulić"]
  s.email       = ["adulic@gmail.com"]
  s.homepage    = "http://github.com/adriandulic/webmeter"
  s.summary     = %q{Website benchmark tool}
  s.description = %q{Simple website benchmark tool written in ruby}

  s.extra_rdoc_files = ["LICENSE", "README.markdown"]

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project = s.name

  s.add_development_dependency "bundler", "1.0.10"
  s.add_development_dependency "rspec", "2.5.0"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
