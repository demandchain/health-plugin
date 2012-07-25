Rails.application.routes.draw do
  get "monitor/ping"
  get "monitor/ident"
  get "monitor/branch"
  get "monitor/env"
end
