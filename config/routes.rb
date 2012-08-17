# Rails.application.routes.draw do
#   mount HealthPlugin::Engine => "/monitor"
#   mount HealthPlugin::Engine => "/site"
# end
HealthPlugin::Engine.routes.draw do
  get "health"
  HealthPlugin::Config::METHOD_NAMES.each do |method|
    get method
  end
end
