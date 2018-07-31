require 'test_helper'

class WsituationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wsituation = wsituations(:one)
  end

  test "should get index" do
    get wsituations_url
    assert_response :success
  end

  test "should get new" do
    get new_wsituation_url
    assert_response :success
  end

  test "should create wsituation" do
    assert_difference('Wsituation.count') do
      post wsituations_url, params: { wsituation: { description: @wsituation.description, multimedia_id: @wsituation.multimedia_id, wfeeling_question_id: @wsituation.wfeeling_question_id, wreaction_question_id: @wsituation.wreaction_question_id } }
    end

    assert_redirected_to wsituation_url(Wsituation.last)
  end

  test "should show wsituation" do
    get wsituation_url(@wsituation)
    assert_response :success
  end

  test "should get edit" do
    get edit_wsituation_url(@wsituation)
    assert_response :success
  end

  test "should update wsituation" do
    patch wsituation_url(@wsituation), params: { wsituation: { description: @wsituation.description, multimedia_id: @wsituation.multimedia_id, wfeeling_question_id: @wsituation.wfeeling_question_id, wreaction_question_id: @wsituation.wreaction_question_id } }
    assert_redirected_to wsituation_url(@wsituation)
  end

  test "should destroy wsituation" do
    assert_difference('Wsituation.count', -1) do
      delete wsituation_url(@wsituation)
    end

    assert_redirected_to wsituations_url
  end
end
