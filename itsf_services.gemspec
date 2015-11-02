$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "itsf/services/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "itsf_services"
  s.version     = Itsf::Services::VERSION
  s.authors     = ["Roberto Vasquez Angel"]
  s.email       = ["roberto.vasquez@anwr-group.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Itsf::Services."
  s.description = "TODO: Description of Itsf::Services."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.4"

  s.add_dependency "deface"
end