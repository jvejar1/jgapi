require 'test_helper'

class WfeelingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wfeeling = wfeelings(:one)
  end

  test "should get index" do
    get wfeelings_url
    assert_response :success
  end

  test "should get new" do
    get new_wfeeling_url
    assert_response :success
  end

  test "should create wfeeling" do
    assert_difference('Wfeeling.count') do
      post wfeelings_url, params: { wfeeling: { index: @wfeeling.index, text: @wfeeling.text } }
    end

    assert_redirected_to wfeeling_url(Wfeeling.last)
  end

  test "should show wfeeling" do
    get wfeeling_url(@wfeeling)
    assert_response :success
  end

  test "should get edit" do
    get edit_wfeeling_url(@wfeeling)
    assert_response :success
  end

  test "should update wfeeling" do
    patch wfeeling_url(@wfeeling), params: { wfeeling: { index: @wfeeling.index, text: @wfeeling.text } }
    assert_redirected_to wfeeling_url(@wfeeling)
  end

  test "should destroy wfeeling" do
    assert_difference('Wfeeling.count', -1) do
      delete wfeeling_url(@wfeeling)
    end

    assert_redirected_to wfeelings_url
  end
end
