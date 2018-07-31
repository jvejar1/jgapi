require 'test_helper'

class WreactionQuestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wreaction_question = wreaction_questions(:one)
  end

  test "should get index" do
    get wreaction_questions_url
    assert_response :success
  end

  test "should get new" do
    get new_wreaction_question_url
    assert_response :success
  end

  test "should create wreaction_question" do
    assert_difference('WreactionQuestion.count') do
      post wreaction_questions_url, params: { wreaction_question: { multimedia_id: @wreaction_question.multimedia_id } }
    end

    assert_redirected_to wreaction_question_url(WreactionQuestion.last)
  end

  test "should show wreaction_question" do
    get wreaction_question_url(@wreaction_question)
    assert_response :success
  end

  test "should get edit" do
    get edit_wreaction_question_url(@wreaction_question)
    assert_response :success
  end

  test "should update wreaction_question" do
    patch wreaction_question_url(@wreaction_question), params: { wreaction_question: { multimedia_id: @wreaction_question.multimedia_id } }
    assert_redirected_to wreaction_question_url(@wreaction_question)
  end

  test "should destroy wreaction_question" do
    assert_difference('WreactionQuestion.count', -1) do
      delete wreaction_question_url(@wreaction_question)
    end

    assert_redirected_to wreaction_questions_url
  end
end
