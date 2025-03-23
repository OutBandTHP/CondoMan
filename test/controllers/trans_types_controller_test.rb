require "test_helper"

class TransTypesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get trans_types_index_url
    assert_response :success
  end

  test "should get show" do
    get trans_types_show_url
    assert_response :success
  end

  test "should get edit" do
    get trans_types_edit_url
    assert_response :success
  end

  test "should get update" do
    get trans_types_update_url
    assert_response :success
  end

  test "should get new" do
    get trans_types_new_url
    assert_response :success
  end

  test "should get create" do
    get trans_types_create_url
    assert_response :success
  end
end
