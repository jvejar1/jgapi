require 'test_helper'

class ApkControllerTest < ActionDispatch::IntegrationTest
  test "should get latest" do
    get apk_latest_url
    assert_response :success
  end

end
