require 'test_helper'

class SteamUserControllerTest < ActionController::TestCase
  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get list" do
    get :list
    assert_response :success
  end

  test "should get steam_group" do
    get :steam_group
    assert_response :success
  end

end
