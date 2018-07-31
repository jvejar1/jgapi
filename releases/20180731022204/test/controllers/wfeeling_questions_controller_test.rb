require 'test_helper'

class WfeelingQuestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wfeeling_question = wfeeling_questions(:one)
  end

  test "should get index" do
    get wfeeling_questions_url
    assert_response :success
  end

  test "should get new" do
    get new_wfeeling_question_url
    assert_response :success
  end

  test "should create wfeeling_question" do
    assert_difference('WfeelingQuestion.count') do
      post wfeeling_questions_url, params: { wfeeling_question: { multimedia_id: @wfeeling_question.multimedia_id } }
    end

    assert_redirected_to wfeeling_question_url(WfeelingQuestion.last)
  end

  test "should show wfeeling_question" do
    get wfeeling_question_url(@wfeeling_question)
    assert_response :success
  end

  test "should get edit" do
    get edit_wfeeling_question_url(@wfeeling_question)
    assert_response :success
  end

  test "should update wfeeling_question" do
    patch wfeeling_question_url(@wfeeling_question), params: { wfeeling_question: { multimedia_id: @wfeeling_question.multimedia_id } }
    assert_redirected_to wfeeling_question_url(@wfeeling_question)
  end

  test "should destroy wfeeling_question" do
    assert_difference('WfeelingQuestion.count', -1) do
      delete wfeeling_question_url(@wfeeling_question)
    end

    assert_redirected_to wfeeling_questions_url
  end
end
