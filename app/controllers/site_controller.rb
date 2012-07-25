class SiteController < ApplicationController

  def ping
    render(:text => SITE_PONG)
  end

  def sha
    render(:text => SITE_SHA)
  end

  def branch
    render(:text => SITE_BRANCH)
  end

  def env
    render(:text => SITE_ENV)
  end

end
