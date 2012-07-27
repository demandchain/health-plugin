Rails.application.routes.draw do
  # Rearden Internal
  get "monitor/state"

  # Offers Internal
  get "monitor/health"
  get "monitor/ping"
  get "monitor/ident"
  get "monitor/branch"
  get "monitor/env"
  get "monitor/describe"
  get "monitor/timestamp"
end
