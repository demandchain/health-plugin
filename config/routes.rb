Rails.application.routes.draw do

  HealthPlugin::Config::METHOD_NAMES.each do |method|
    get "monitor/#{method}"
  end

end
