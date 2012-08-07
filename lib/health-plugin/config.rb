require "ostruct"
require "mixlib/config"

module HealthPlugin
  class Config
    extend(::Mixlib::Config)

    METHOD_NAMES = %w( state branch describe env ident ping timestamp )

    prefix "X-App"

    callbacks OpenStruct.new
    METHOD_NAMES.each do |method|
      class_eval <<-EOC, __FILE__, __LINE__ + 1
        callbacks.#{method} = Proc.new do
          raise "You must set the '#{method}' callback Proc!"
        end
      EOC
    end

  end
end
