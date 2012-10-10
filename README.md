# Offers Health Plugin

This is a Rails (>= 3.1.0) plugin to enable functionality for monitoring of a Rails application via the Offers Health Application.

No modification of the host Rails application should be required; add the gem to your bundler `Gemfile` and configure the `health-plugin` via an initializer in your host application.

## Initializer

You will need an initializer in your mail Rails application to configure the health-plugin.  Each callback maps to a health-plugin URI for the host application.  Each callback `Proc` should return a `Hash` formatted as follows:

1. A `header` value; this is rendered as a header in the HTTP response for the corresponding health-plugin URI.

2. A `body` value; this is rendered as the body of the HTTP response for the corresponding health-plugin URI.

3. A `status` value; this is rendered as the HTTP response code for the corresponding health-plugin URI.

The following callbacks exists: `state branch describe env ident ping timestamp`

All headers are prefixed with the value from `config.prefix`.  In the example below; the `env` callback, for example, would end up with `X-Rearden-Env` as it's header.

Here is an example initializer for the health-plugin from UMD:

    module Health
      class << self

        def ping
          ping = Array.new
          ping << disabled
          ping << galaxy
          ping << redis
          ping.compact.join('|')
        end

        def disabled
          File.exists?(File.join(Rails.root, ".disabled")) and return "PANG DISABLED"
          nil
        end

        def redis
          Redis.current.info and return "PONG REDIS"
          "PANG REDIS"
        rescue Exception => e
          "PANG REDIS #{e.inspect}"
        end

        def galaxy
          site = URI(Galaxy::Base.site.to_s.dup)
          site.path = "/site/ping"
          Array(200..299).include?(Net::HTTP.get_response(site).code.to_i) and return "PONG GALAXY"
          "PANG GALAXY"
        rescue Exception => e
          "PANG GALAXY #{e.inspect}"
        end

      end
    end

    HealthPlugin.config do |config|
      config.prefix = "X-Rearden"
      config.mounts += %w( site )

      config.callbacks.ping = Proc.new do
        ping = Health.ping
        status = (ping =~ /PANG/ ? 501 : 200)
        {
          header: ping,
          body: ping,
          status: status
        }
      end

      config.callbacks.state = Proc.new do
        ping = Health.ping
        state = (ping =~ /PANG/ ? 'OFF' : 'ON')
        {
          header: state,
          body: nil,
          status: 204
        }
      end

    end
