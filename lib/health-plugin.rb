require "ostruct"
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

  HealthPlugin::Config::METHOD_NAMES.each do |method|
    class_eval <<-EOC, __FILE__, __LINE__ + 1
      def self.#{method}
        result = HealthPlugin.config.callbacks.#{method}.call
        !result.is_a?(Hash) and raise("Callback Proc '#{method}' must return a Hash object!")
        OpenStruct.new({ status: 200 }.merge(result))
      end
    EOC
  end

end
