module HealthPlugin

  module Rack
    class Monitor

      def initialize(app)
        @app = app
      end

      def call(env)
        req = ::Rack::Request.new(env)
        if req.path =~ /^\/(#{HealthPlugin::Config.mounts.join("|")})\/health\/?$/
          result = HealthPlugin::Config.checks.inject({}) do |result,method|
            result["#{HealthPlugin.config.prefix}-#{method.capitalize}"] = HealthPlugin.send(method).header
            result
          end
          [204, result.merge({ 'Content-Type' => 'text/html', 'Content-Length' => "0" }), []]
        elsif method = HealthPlugin::Config.checks.find{|check| req.path =~ /^\/(#{HealthPlugin::Config.mounts.join("|")})\/#{check.to_s}\/?$/}
          result = HealthPlugin.send(method)
          body = (result.body || '')
          [result.status, { "#{HealthPlugin.config.prefix}-#{method.capitalize}" => result.header  ,'Content-Type' => 'text/html', 'Content-Length' => body.size.to_s }, [body]]
        else
          @app.call(env)
        end
      end

    end
  end

end
