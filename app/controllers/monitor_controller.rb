class MonitorController < ApplicationController
  skip_filter(*_process_action_callbacks.map(&:filter))

  def state
    headers["X-Rearden-App-Traffic"] = (File.exists?(MONITOR_LB_SEMAPHORE_FILE) ? "OFF" : "ON")
    render(:nothing => true, :status => 200)
  end

  def ping
    render(:text => (File.exists?(MONITOR_LB_SEMAPHORE_FILE) ? MONITOR_PANG : MONITOR_PONG))
  end

  def ident
    render(:text => MONITOR_IDENT)
  end

  def branch
    render(:text => MONITOR_BRANCH)
  end

  def env
    render(:text => MONITOR_ENV)
  end

end
