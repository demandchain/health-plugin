class MonitorController < ApplicationController
  skip_filter(*_process_action_callbacks.map(&:filter))

  def state
    headers["#{HealthPlugin.state[:header]}"] = (HealthPlugin.callbacks[:check].call ? HealthPlugin.state[:success] : HealthPlugin.state[:failure])
    render(:nothing => true, :status => 204)
  end

  def health
    headers["#{HealthPlugin.health[:header_prefix]}-Ping"] = (HealthPlugin.callbacks[:check].call ? HealthPlugin.state[:success] : HealthPlugin.state[:failure])
    headers["#{HealthPlugin.health[:header_prefix]}-Ident"] = HealthPlugin.callbacks[:ident].call
    headers["#{HealthPlugin.health[:header_prefix]}-Branch"] = HealthPlugin.callbacks[:branch].call
    headers["#{HealthPlugin.health[:header_prefix]}-Env"] = HealthPlugin.callbacks[:env].call
    headers["#{HealthPlugin.health[:header_prefix]}-Describe"] = HealthPlugin.callbacks[:describe].call
    headers["#{HealthPlugin.health[:header_prefix]}-Timestamp"] = HealthPlugin.callbacks[:timestamp].call
    render(:nothing => true, :status => 204)
  end

  def ping
    render(:text => (HealthPlugin.callbacks[:check].call ? HealthPlugin.state[:success] : HealthPlugin.state[:failure]))
  end

  def ident
    render(:text => HealthPlugin.callbacks[:ident])
  end

  def branch
    render(:text => HealthPlugin.callbacks[:branch])
  end

  def env
    render(:text => HealthPlugin.callbacks[:env])
  end

  def describe
    render(:text => HealthPlugin.callbacks[:describe])
  end

  def timestamp
    render(:text => HealthPlugin.callbacks[:timestamp])
  end

end
