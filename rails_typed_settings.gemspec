$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_typed_settings/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_typed_settings"
  s.version     = RailsTypedSettings::VERSION
  s.authors     = ["Kaom Te"]
  s.email       = ["kaom@tekkinnovations.com"]
  s.homepage    = "http://www.tekkinnovations.com"
  s.metadata = { "github_repo" => "ssh://github.com/kaomte/rails_typed_settings" }
  s.summary     = "Typed settings for rails."
  s.description = "Typed settings for rails."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 5.2.0"

  s.add_development_dependency "sqlite3"
end
