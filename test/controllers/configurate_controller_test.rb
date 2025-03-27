require "test_helper"

class ConfigurateControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get configurate_show_url
    assert_response :success
  end

  test "should get edit" do
    get configurate_edit_url
    assert_response :success
  end
end
