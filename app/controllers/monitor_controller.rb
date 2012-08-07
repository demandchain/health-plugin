class MonitorController < ApplicationController
  skip_filter(*_process_action_callbacks.map(&:filter))

  def health
    HealthPlugin::Config::METHOD_NAMES.each do |method|
      instance_eval <<-EOC, __FILE__, __LINE__ + 1
        result = HealthPlugin.#{method}
        result.nil? and raise "Result can not be nil!"
        result.header.nil? and raise "Header can not be nil!"
        result.status.nil? and raise "Status can not be nil!"

        headers["#{HealthPlugin.config.prefix}-#{method.capitalize}"] = result.header
      EOC
    end
    render(nothing: true, status: 200)
  end

  HealthPlugin::Config::METHOD_NAMES.each do |method|
    class_eval <<-EOC, __FILE__, __LINE__ + 1
      def #{method}
        result = HealthPlugin.#{method}
        result.nil? and raise "Result can not be nil!"
        result.header.nil? and raise "Header can not be nil!"
        result.status.nil? and raise "Status can not be nil!"

        headers["#{HealthPlugin.config.prefix}-#{method.capitalize}"] = result.header
        render(text: result.body, status: result.status)
      end
    EOC
  end

end
