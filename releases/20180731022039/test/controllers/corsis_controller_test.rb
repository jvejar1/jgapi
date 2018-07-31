require 'test_helper'

class CorsisControllerTest < ActionDispatch::IntegrationTest
  setup do
    @corsi = corsis(:one)
  end

  test "should get index" do
    get corsis_url
    assert_response :success
  end

  test "should get new" do
    get new_corsi_url
    assert_response :success
  end

  test "should create corsi" do
    assert_difference('Corsi.count') do
      post corsis_url, params: { corsi: { current: @corsi.current, version: @corsi.version } }
    end

    assert_redirected_to corsi_url(Corsi.last)
  end

  test "should show corsi" do
    get corsi_url(@corsi)
    assert_response :success
  end

  test "should get edit" do
    get edit_corsi_url(@corsi)
    assert_response :success
  end

  test "should update corsi" do
    patch corsi_url(@corsi), params: { corsi: { current: @corsi.current, version: @corsi.version } }
    assert_redirected_to corsi_url(@corsi)
  end

  test "should destroy corsi" do
    assert_difference('Corsi.count', -1) do
      delete corsi_url(@corsi)
    end

    assert_redirected_to corsis_url
  end
end
