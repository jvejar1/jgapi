require 'test_helper'

class MultimediaControllerTest < ActionDispatch::IntegrationTest
  setup do
    @multimedium = multimedia(:one)
  end

  test "should get index" do
    get multimedia_url
    assert_response :success
  end

  test "should get new" do
    get new_multimedium_url
    assert_response :success
  end

  test "should create multimedium" do
    assert_difference('Multimedium.count') do
      post multimedia_url, params: { multimedium: { image: @multimedium.image } }
    end

    assert_redirected_to multimedium_url(Multimedium.last)
  end

  test "should show multimedium" do
    get multimedium_url(@multimedium)
    assert_response :success
  end

  test "should get edit" do
    get edit_multimedium_url(@multimedium)
    assert_response :success
  end

  test "should update multimedium" do
    patch multimedium_url(@multimedium), params: { multimedium: { image: @multimedium.image } }
    assert_redirected_to multimedium_url(@multimedium)
  end

  test "should destroy multimedium" do
    assert_difference('Multimedium.count', -1) do
      delete multimedium_url(@multimedium)
    end

    assert_redirected_to multimedia_url
  end
end
