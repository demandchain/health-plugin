Rails.application.routes.draw do

  get "monitor/health"
  HealthPlugin::Config::METHOD_NAMES.each do |method|
    get "monitor/#{method}"
  end

end
