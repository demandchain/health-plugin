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

Here is an example initializer for the health-plugin:

    HealthPlugin.config do |config|

      config.prefix = "X-Rearden"

      config.callbacks.state = Proc.new do
        state = (File.exists?(File.join(Rails.root, ".disabled")) ? "OFF" : "ON")
        {
          header: state,
          body: nil,
          status: 204
        }
      end

      config.callbacks.branch = Proc.new do
        branch = (IO.read(File.join(Rails.root, "BRANCH")) rescue "N/A")
        {
          header: branch,
          body: branch,
          status: 200
        }
      end

      config.callbacks.describe = Proc.new do
        describe = %x(git describe 2>/dev/null).chomp
        describe.blank? and describe = "N/A"
        {
          header: describe,
          body: describe,
          status: 200
        }
      end

      config.callbacks.env = Proc.new do
        env = Rails.env
        {
          header: env,
          body: env,
          status: 200
        }
      end

      config.callbacks.ident = Proc.new do
        ident = (IO.read(File.join(Rails.root, "REVISION")) rescue "N/A")
        {
          header: ident,
          body: ident,
          status: 200
        }
      end

      config.callbacks.ping = Proc.new do
        ping = (File.exists?(File.join(Rails.root, ".disabled")) ? "PANG" : "PONG")
        status = (File.exists?(File.join(Rails.root, ".disabled")) ? 501 : 200)
        {
          header: ping,
          body: ping,
          status: status
        }
      end

      config.callbacks.timestamp = Proc.new do
        timestamp = %x(git log -1 --pretty=format:"%aD" 2>/dev/null).chomp || "N/A"
        timestamp.blank? and timestamp = "N/A"
        {
          header: timestamp,
          body: timestamp,
          status: 200
        }
      end

    end
