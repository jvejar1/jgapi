require 'test_helper'

class AcesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ace = aces(:one)
  end

  test "should get index" do
    get aces_url
    assert_response :success
  end

  test "should get new" do
    get new_ace_url
    assert_response :success
  end

  test "should create ace" do
    assert_difference('Ace.count') do
      post aces_url, params: { ace: { current: @ace.current, version: @ace.version } }
    end

    assert_redirected_to ace_url(Ace.last)
  end

  test "should show ace" do
    get ace_url(@ace)
    assert_response :success
  end

  test "should get edit" do
    get edit_ace_url(@ace)
    assert_response :success
  end

  test "should update ace" do
    patch ace_url(@ace), params: { ace: { current: @ace.current, version: @ace.version } }
    assert_redirected_to ace_url(@ace)
  end

  test "should destroy ace" do
    assert_difference('Ace.count', -1) do
      delete ace_url(@ace)
    end

    assert_redirected_to aces_url
  end
end
