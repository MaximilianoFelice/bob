$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "bob/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "bob-builder"
  s.version     = Bob::VERSION
  s.authors     = ["Maximiliano Felice"]
  s.email       = ["maximilianofelice@gmail.com"]
  s.homepage    = "https://github.com/MaximilianoFelice/bob"
  s.summary     = "Bob is a Builder Rails tool for generating data."
  s.description = "Bob helps you generate a complex, robust data layer for getting you rails application fully populated."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.required_ruby_version = ">= 2.1.0"

  s.add_dependency "rails", ">= 3.2.0"

end
