require 'test_helper'

class ParticipantsFilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @participants_file = participants_files(:one)
  end

  test "should get index" do
    get participants_files_url
    assert_response :success
  end

  test "should get new" do
    get new_participants_file_url
    assert_response :success
  end

  test "should create participants_file" do
    assert_difference('ParticipantsFile.count') do
      post participants_files_url, params: { participants_file: { user_id: @participants_file.user_id, year: @participants_file.year } }
    end

    assert_redirected_to participants_file_url(ParticipantsFile.last)
  end

  test "should show participants_file" do
    get participants_file_url(@participants_file)
    assert_response :success
  end

  test "should get edit" do
    get edit_participants_file_url(@participants_file)
    assert_response :success
  end

  test "should update participants_file" do
    patch participants_file_url(@participants_file), params: { participants_file: { user_id: @participants_file.user_id, year: @participants_file.year } }
    assert_redirected_to participants_file_url(@participants_file)
  end

  test "should destroy participants_file" do
    assert_difference('ParticipantsFile.count', -1) do
      delete participants_file_url(@participants_file)
    end

    assert_redirected_to participants_files_url
  end
end
