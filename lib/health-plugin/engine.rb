module HealthPlugin

  class Engine < Rails::Engine
    isolate_namespace HealthPlugin

    config.app_middleware.insert(0, HealthPlugin::Rack::Monitor)
  end

end
