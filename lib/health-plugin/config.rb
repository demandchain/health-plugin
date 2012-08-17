require "ostruct"
require "mixlib/config"

module HealthPlugin
  class Config
    extend(::Mixlib::Config)

    METHOD_NAMES = %w( state branch describe env ident ping timestamp )

    prefix "X-App"

    monitor_semaphore_file ".disabled"

    callbacks OpenStruct.new({
      :state => Proc.new {
        state = (File.exists?(File.join(Rails.root,monitor_semaphore_file)) ? "OFF" : "ON")
        {
          header: state,
          body: nil,
          status: 204
        }
      },
      :branch => Proc.new {
        branch = (IO.read(File.join(Rails.root, "BRANCH")) rescue "N/A")
        {
          header: branch,
          body: branch,
          status: 200
        }
      },
      :describe => Proc.new {
        describe = %x(git describe 2>/dev/null).chomp
        describe.blank? and describe = "N/A"
        {
          header: describe,
          body: describe,
          status: 200
        }
      },
      :env => Proc.new {
        env = Rails.env
        {
          header: env,
          body: env,
          status: 200
        }
      },
      :ident => Proc.new {
        ident = (IO.read(File.join(Rails.root, "REVISION")) rescue "N/A")
        {
          header: ident,
          body: ident,
          status: 200
        }
      },
      :ping => Proc.new {
        ping = (File.exists?(File.join(Rails.root, monitor_semaphore_file)) ? "PANG" : "PONG")
        status = (File.exists?(File.join(Rails.root, monitor_semaphore_file)) ? 501 : 200)
        {
          header: ping,
          body: ping,
          status: status
        }
      },
      :timestamp => Proc.new {
        timestamp = %x(git log -1 --pretty=format:"%aD" 2>/dev/null).chomp || "N/A"
        timestamp.blank? and timestamp = "N/A"
        {
          header: timestamp,
          body: timestamp,
          status: 200
        }
      }
    })

  end
end
