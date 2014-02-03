$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "health-plugin/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "health-plugin"
  s.version     = HealthPlugin::VERSION
  s.authors     = ["Zachary Patten"]
  s.email       = ["zpatten@deem.com"]
  s.homepage    = "https://github.com/demandchain/health-plugin"
  s.summary     = "Rails Health Plugin (Requires Rails >= 3.1.0)"
  s.description = "Rails Health Plugin (Requires Rails >= 3.1.0)"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3.1.0"
  s.add_dependency "mixlib-config", "~> 1.1.2"

end
