require 'test_helper'

class CsequencesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @csequence = csequences(:one)
  end

  test "should get index" do
    get csequences_url
    assert_response :success
  end

  test "should get new" do
    get new_csequence_url
    assert_response :success
  end

  test "should create csequence" do
    assert_difference('Csequence.count') do
      post csequences_url, params: { csequence: { sequence: @csequence.sequence } }
    end

    assert_redirected_to csequence_url(Csequence.last)
  end

  test "should show csequence" do
    get csequence_url(@csequence)
    assert_response :success
  end

  test "should get edit" do
    get edit_csequence_url(@csequence)
    assert_response :success
  end

  test "should update csequence" do
    patch csequence_url(@csequence), params: { csequence: { sequence: @csequence.sequence } }
    assert_redirected_to csequence_url(@csequence)
  end

  test "should destroy csequence" do
    assert_difference('Csequence.count', -1) do
      delete csequence_url(@csequence)
    end

    assert_redirected_to csequences_url
  end
end
