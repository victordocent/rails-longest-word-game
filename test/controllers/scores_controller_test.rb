require "test_helper"

class ScoresControllerTest < ActionDispatch::IntegrationTest
  test "should get score" do
    get scores_score_url
    assert_response :success
  end
end
