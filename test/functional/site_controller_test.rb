require 'test_helper'

class SiteControllerTest < ActionController::TestCase
  test "should get ping" do
    get :ping
    assert_response :success
  end

  test "should get sha" do
    get :sha
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
