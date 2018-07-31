require 'test_helper'

class AfeelingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @afeeling = afeelings(:one)
  end

  test "should get index" do
    get afeelings_url
    assert_response :success
  end

  test "should get new" do
    get new_afeeling_url
    assert_response :success
  end

  test "should create afeeling" do
    assert_difference('Afeeling.count') do
      post afeelings_url, params: { afeeling: { index: @afeeling.index, text: @afeeling.text } }
    end

    assert_redirected_to afeeling_url(Afeeling.last)
  end

  test "should show afeeling" do
    get afeeling_url(@afeeling)
    assert_response :success
  end

  test "should get edit" do
    get edit_afeeling_url(@afeeling)
    assert_response :success
  end

  test "should update afeeling" do
    patch afeeling_url(@afeeling), params: { afeeling: { index: @afeeling.index, text: @afeeling.text } }
    assert_redirected_to afeeling_url(@afeeling)
  end

  test "should destroy afeeling" do
    assert_difference('Afeeling.count', -1) do
      delete afeeling_url(@afeeling)
    end

    assert_redirected_to afeelings_url
  end
end
