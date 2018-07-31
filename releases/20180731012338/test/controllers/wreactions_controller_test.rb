require 'test_helper'

class WreactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wreaction = wreactions(:one)
  end

  test "should get index" do
    get wreactions_url
    assert_response :success
  end

  test "should get new" do
    get new_wreaction_url
    assert_response :success
  end

  test "should create wreaction" do
    assert_difference('Wreaction.count') do
      post wreactions_url, params: { wreaction: { index: @wreaction.index, text: @wreaction.text } }
    end

    assert_redirected_to wreaction_url(Wreaction.last)
  end

  test "should show wreaction" do
    get wreaction_url(@wreaction)
    assert_response :success
  end

  test "should get edit" do
    get edit_wreaction_url(@wreaction)
    assert_response :success
  end

  test "should update wreaction" do
    patch wreaction_url(@wreaction), params: { wreaction: { index: @wreaction.index, text: @wreaction.text } }
    assert_redirected_to wreaction_url(@wreaction)
  end

  test "should destroy wreaction" do
    assert_difference('Wreaction.count', -1) do
      delete wreaction_url(@wreaction)
    end

    assert_redirected_to wreactions_url
  end
end
