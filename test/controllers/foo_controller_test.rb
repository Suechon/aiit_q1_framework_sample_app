require "test_helper"

class FooControllerTest < ActionDispatch::IntegrationTest
  test "should get ber" do
    get foo_ber_url
    assert_response :success
  end

  test "should get baz" do
    get foo_baz_url
    assert_response :success
  end
end
