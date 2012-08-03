# Offers Health Plugin

This is a Rails (>= 3.1.0) plugin to enable functionality for monitoring of a Rails application via the Offers Health Application.

No modification of the host Rails application should be required.  Keep in mind this namespace is now isolated!

## Configuration

There are two main URIs to the health plugin.  The first is the state URI, which is meant for load balancers and other hardward that can switch state based on the header returned.  The second is the health URI which is meant for the dashboard.

### State

URI: `/monitor/state`

    HealthPlugin.config do |config|
      config.state.header = "X-Rearden-App-Traffic"
      config.state.success = "ON"
      config.state.failure = "OFF"
    end

### Health

URI: `/monitor/health`

    HealthPlugin.config do |config|
      config.health.header_prefix = "X-App"
    end

### Callbacks

These are various callback hooks which the health plugin uses to determine state information.  You need to use a `Proc` block for all of these with the exception of the `check` callback.

#### `check`

Should return a `Boolean` indicating the overall state of the application.  This is mainly used for load balancer checks.  You can check anything you need to in the `Proc` block here.  If the application is able to service requests you should return `True` otherwise `False`.

    HealthPlugin.config do |config|
      config.callbacks.check = Proc.new do
        !File.exists?(File.join(Rails.root, ".disabled"))
      end
    end

#### `ident`

Should return a `String` providing a way to identify this deployment.  In the case of Git, this would be the SHA of the deployed branch.

    HealthPlugin.config do |config|
      config.callbacks.ident = Proc.new do
        (IO.read(File.join(Rails.root, "REVISION")) rescue "N/A")
      end
    end

#### `branch`

Should return a `String` providing the current branch that is deployed.

    HealthPlugin.config do |config|
      config.callbacks.branch = Proc.new do
        (IO.read(File.join(Rails.root, "BRANCH")) rescue "N/A")
      end
    end

#### `env`

Should return a `String` providing the environment of the application (i.e. development, staging, production, etc.).

    HealthPlugin.config do |config|
      config.callbacks.env = Proc.new do
        Rails.env
      end
    end

#### `describe`

Should return a `String` providing concise version information for the current deployment.  In the case of Git, this would be the `git describe` command.

    HealthPlugin.config do |config|
      config.callbacks.describe = Proc.new do
        describe = %x(git describe 2>/dev/null).chomp
        (describe.present? ? describe : "N/A")
      end
    end


#### `timestamp`

Should return a `String` providing the timestamp of when the application was deployed or when the last commit on the currently deployed branch was.

    HealthPlugin.config do |config|
      config.callbacks.timestamp = Proc.new do
        timestamp = %x(git log -1 --pretty=format:"%aD" 2>/dev/null).chomp
        (timestamp.present? ? timestamp : "N/A")
      end
    end
