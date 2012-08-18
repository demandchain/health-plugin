# HealthPlugin::Engine.routes.draw do
#   get "health"
#   HealthPlugin::Config::METHOD_NAMES.each do |method|
#     get method
#   end
# end

# Rails.application.routes.draw do
#   mount HealthPlugin::Engine => "/monitor"
# end

#HealthPlugin::Engine.routes.draw do
#  get "monitor/health"
#  HealthPlugin::Config::METHOD_NAMES.each do |method|
#    get "monitor/#{method}"
#  end
#end
