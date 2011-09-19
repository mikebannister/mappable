$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mappable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mappable"
  s.version     = Mappable::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Mappable."
  s.description = "TODO: Description of Mappable."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.1.0"

  s.add_development_dependency "sqlite3", "~> 1.3.4"
  s.add_development_dependency "rspec-rails", "~> 2.6.1"
  s.add_development_dependency "capybara", "~> 1.1.1"
end
