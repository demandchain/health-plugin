require 'test_helper'

class MonitorControllerTest < ActionController::TestCase

  test "should get ping" do
    get :ping
    assert_response :success
  end

  test "should get ident" do
    get :ident
    assert_response :success
  end

  test "should get branch" do
    get :branch
    assert_response :success
  end

  test "should get env" do
    get :env
    assert_response :success
  end

end
