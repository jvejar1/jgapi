require 'test_helper'

class AcasesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @acase = acases(:one)
  end

  test "should get index" do
    get acases_url
    assert_response :success
  end

  test "should get new" do
    get new_acase_url
    assert_response :success
  end

  test "should create acase" do
    assert_difference('Acase.count') do
      post acases_url, params: { acase: { ace_id: @acase.ace_id, index: @acase.index } }
    end

    assert_redirected_to acase_url(Acase.last)
  end

  test "should show acase" do
    get acase_url(@acase)
    assert_response :success
  end

  test "should get edit" do
    get edit_acase_url(@acase)
    assert_response :success
  end

  test "should update acase" do
    patch acase_url(@acase), params: { acase: { ace_id: @acase.ace_id, index: @acase.index } }
    assert_redirected_to acase_url(@acase)
  end

  test "should destroy acase" do
    assert_difference('Acase.count', -1) do
      delete acase_url(@acase)
    end

    assert_redirected_to acases_url
  end
end
