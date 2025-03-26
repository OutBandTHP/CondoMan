require "test_helper"

class DeployBooksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get deploy_books_index_url
    assert_response :success
  end

  test "should get edit" do
    get deploy_books_edit_url
    assert_response :success
  end

  test "should get new" do
    get deploy_books_new_url
    assert_response :success
  end
end
