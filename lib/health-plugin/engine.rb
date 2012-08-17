module HealthPlugin
  class Engine < Rails::Engine
    isolate_namespace HealthPlugin
    config.railties_order = [HealthPlugin::Engine, :main_app, :all]
  end
end
