class MonitorController < ApplicationController

  def ping
    render(:text => (File.exists?(MONITOR_LB_SEMAPHORE_FILE) ? MONITOR_PANG : MONITOR_PONG))
  end

  def ident
    render(:text => MONITOR_SHA)
  end

  def branch
    render(:text => MONITOR_BRANCH)
  end

  def env
    render(:text => MONITOR_ENV)
  end

end
