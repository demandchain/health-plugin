require "ostruct"
require "mixlib/config"

module HealthPlugin
  class Config
    extend(::Mixlib::Config)

    state OpenStruct.new
    state.header = "X-App-Traffic"
    state.success = "ON"
    state.failure = "OFF"

    health OpenStruct.new
    health.header_prefix = "X-App"

    callbacks OpenStruct.new
    callbacks.check = Proc.new do
      !File.exists?(File.join(Rails.root, ".disabled"))
    end

    callbacks.ident = Proc.new do
      (IO.read(File.join(Rails.root, "REVISION")) rescue "N/A")
    end

    callbacks.branch = Proc.new do
      (IO.read(File.join(Rails.root, "BRANCH")) rescue "N/A")
    end

    callbacks.env = Proc.new do
      Rails.env
    end

    callbacks.describe = Proc.new do
      describe = %x(git describe 2>/dev/null).chomp
      (describe.present? ? describe : "N/A")
    end

    callbacks.timestamp = Proc.new do
      timestamp = %x(git log -1 --pretty=format:"%aD" 2>/dev/null).chomp
      (timestamp.present? ? timestamp : "N/A")
    end
  end
end

