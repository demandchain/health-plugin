require "health-plugin/config"
require "health-plugin/engine"

module HealthPlugin

  def self.config(&block)
    if block_given?
      yield(HealthPlugin::Config)
    else
      HealthPlugin::Config
    end
  end

end
