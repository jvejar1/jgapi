require 'test_helper'

class WalliesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wally = wallies(:one)
  end

  test "should get index" do
    get wallies_url
    assert_response :success
  end

  test "should get new" do
    get new_wally_url
    assert_response :success
  end

  test "should create wally" do
    assert_difference('Wally.count') do
      post wallies_url, params: { wally: { current: @wally.current, description: @wally.description, version: @wally.version } }
    end

    assert_redirected_to wally_url(Wally.last)
  end

  test "should show wally" do
    get wally_url(@wally)
    assert_response :success
  end

  test "should get edit" do
    get edit_wally_url(@wally)
    assert_response :success
  end

  test "should update wally" do
    patch wally_url(@wally), params: { wally: { current: @wally.current, description: @wally.description, version: @wally.version } }
    assert_redirected_to wally_url(@wally)
  end

  test "should destroy wally" do
    assert_difference('Wally.count', -1) do
      delete wally_url(@wally)
    end

    assert_redirected_to wallies_url
  end
end
