require 'test_helper'

class GamesControllerTest < ActionDispatch::IntegrationTest
  test "should get save" do
    get games_save_url
    assert_response :success
  end

end
