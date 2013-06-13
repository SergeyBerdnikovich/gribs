require 'test_helper'

class NotificationModesControllerTest < ActionController::TestCase
  setup do
    @notification_mode = notification_modes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:notification_modes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create notification_mode" do
    assert_difference('NotificationMode.count') do
      post :create, notification_mode: { name: @notification_mode.name }
    end

    assert_redirected_to notification_mode_path(assigns(:notification_mode))
  end

  test "should show notification_mode" do
    get :show, id: @notification_mode
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @notification_mode
    assert_response :success
  end

  test "should update notification_mode" do
    put :update, id: @notification_mode, notification_mode: { name: @notification_mode.name }
    assert_redirected_to notification_mode_path(assigns(:notification_mode))
  end

  test "should destroy notification_mode" do
    assert_difference('NotificationMode.count', -1) do
      delete :destroy, id: @notification_mode
    end

    assert_redirected_to notification_modes_path
  end
end
