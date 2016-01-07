require 'test_helper'

class VisitorsControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get index if logged in" do
    log_in_as(users(:john))
    get :index
    assert_response :success
  end

end
