require "test_helper"

class GamesControllerTest < ActionDispatch::IntegrationTest
  test "should get settings" do
    get games_settings_url
    assert_response :success
  end
end
