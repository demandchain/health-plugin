require "spec_helper"

describe "test controller routing" do

  before(:each) { @routes = HealthPlugin::Engine.routes }

  it "routes without blowing up" do
    get(monitor_health_path).should route_to(:controller => "monitor", :action => "health")
    get(monitor_ident_path).should route_to(:controller => "monitor", :action => "ident")
    get(monitor_env_path).should route_to(:controller => "monitor", :action => "env")
    get(monitor_branch_path).should route_to(:controller => "monitor", :action => "branch")
    get(monitor_state_path).should route_to(:controller => "monitor", :action => "state")
    get(monitor_describe_path).should route_to(:controller => "monitor", :action => "describe")
  end

end
