Rails.application.routes.draw do

  get "monitor/health"
  HealthPlugin::Config::METHOD_NAMES.each do |method|
    get "monitor/#{method}"
  end

  # TODO: needs to be eventually removed; put here for backward compatibility
  get "site/health"
  HealthPlugin::Config::METHOD_NAMES.each do |method|
    get "site/#{method}"
  end

end
