require "spec_helper"

describe "HealthPlugin::Engine requests" do

  before(:each) { @routes = HealthPlugin::Engine.routes }

  it "gets '/monitor/health'" do
    get("/monitor/health")
    assert_response :success
  end

  it "gets '/monitor/ident'" do
    get("/monitor/ident")
    assert_response :success
  end

  it "gets '/monitor/env'" do
    get("/monitor/env")
    assert_response :success
  end

  it "gets '/monitor/branch'" do
    get("/monitor/branch")
    assert_response :success
  end

  it "gets '/monitor/state'" do
    get("/monitor/state")
    assert_response :success
  end

  it "gets '/monitor/describe'" do
    get("/monitor/describe")
    assert_response :success
  end

end
