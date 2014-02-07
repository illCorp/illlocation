$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "illlocation/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "illlocation"
  s.version     = Illlocation::VERSION
  s.authors     = ["ILL Co."]
  s.email       = ["mike@illcorporation.com", "sean@illcorporation.com", "mat@illcorporation.com"]
  s.homepage    = ""
  s.summary     = "illlocation #{s.version}"
  s.description = "A Rails mountable engine gem with PostGIS location utilities."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.0.2"

  s.add_development_dependency "rspec-rails", "~> 3.0.0.beta"
  s.add_development_dependency 'factory_girl_rails', '~> 4.3.0'
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "pg"
  s.add_development_dependency "activerecord-postgis-adapter"
end
