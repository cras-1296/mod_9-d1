require "test_helper"

class ApartmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get apartments_new_url
    assert_response :success
  end

  test "should get create" do
    get apartments_create_url
    assert_response :success
  end

  test "should get index" do
    get apartments_index_url
    assert_response :success
  end

  test "should get show" do
    get apartments_show_url
    assert_response :success
  end
end
