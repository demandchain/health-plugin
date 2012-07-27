class MonitorController < ApplicationController
  skip_filter(*_process_action_callbacks.map(&:filter))

  def state
    headers["X-Rearden-App-Traffic"] = (File.exists?(MONITOR_LB_SEMAPHORE_FILE) ? "OFF" : "ON")
    render(:nothing => true, :status => 204)
  end

  def health
    headers["X-Site-Ping"] = (File.exists?(MONITOR_LB_SEMAPHORE_FILE) ? MONITOR_PANG : MONITOR_PONG)
    headers["X-Site-Ident"] = DEPLOYED_IDENT
    headers["X-Site-Branch"] = DEPLOYED_BRANCH
    headers["X-Site-Env"] = DEPLOYED_ENV
    headers["X-Site-Describe"] = DEPLOYED_DESCRIBE
    headers["X-Site-Timestamp"] = DEPLOYED_TIMESTAMP
    render(:nothing => true, :status => 204)
  end

  def ping
    render(:text => (File.exists?(MONITOR_LB_SEMAPHORE_FILE) ? MONITOR_PANG : MONITOR_PONG))
  end

  def ident
    render(:text => DEPLOYED_IDENT)
  end

  def branch
    render(:text => DEPLOYED_BRANCH)
  end

  def env
    render(:text => DEPLOYED_ENV)
  end

  def describe
    render(:text => DEPLOYED_DESCRIBE)
  end

  def timestamp
    render(:text => DEPLOYED_TIMESTAMP)
  end

end
