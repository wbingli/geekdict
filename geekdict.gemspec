# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "geekdict/version"

Gem::Specification.new do |s|
  s.name        = "geekdict"
  s.version     = GeekDict::VERSION
  s.authors     = ["Bruce Li"]
  s.email       = ["wbinglee@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{A command line tool for translation.}
  s.description = %q{A command line tool for translation.}

  s.rubyforge_project = "geekdict"

  s.files = %w[LICENSE README.md geekdict.gemspec Gemfile Rakefile]
  s.files += Dir.glob("bin/**/*")
  s.files += Dir.glob("lib/**/*.rb")
  s.files += Dir.glob("spec/**/*")
  s.test_files    = Dir.glob("spec/**/*")
  s.executables   =  %w[geekdict]
  s.require_paths = ["lib"]

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec", "~> 2.13.0"

  s.add_runtime_dependency "thor", "~> 0.19.1"
  s.add_runtime_dependency "httpclient", "~> 2.4.0"

end
