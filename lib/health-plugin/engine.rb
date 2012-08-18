module HealthPlugin

  class Engine < Rails::Engine
    isolate_namespace HealthPlugin
    config.app_middleware.use HealthPlugin::Rack::Monitor
  end

end


