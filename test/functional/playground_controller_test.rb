require 'test_helper'

class PlaygroundControllerTest < ActionController::TestCase
  test "should get dash" do
    get :dash
    assert_response :success
  end

end
