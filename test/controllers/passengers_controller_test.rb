require "test_helper"

class PassengersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get passengers_show_url
    assert_response :success
  end
end
