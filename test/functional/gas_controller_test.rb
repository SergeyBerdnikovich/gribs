require 'test_helper'

class GasControllerTest < ActionController::TestCase
  setup do
    @ga = gas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ga" do
    assert_difference('Ga.count') do
      post :create, ga: { date_update: @ga.date_update, product_id: @ga.product_id, qty: @ga.qty }
    end

    assert_redirected_to ga_path(assigns(:ga))
  end

  test "should show ga" do
    get :show, id: @ga
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ga
    assert_response :success
  end

  test "should update ga" do
    put :update, id: @ga, ga: { date_update: @ga.date_update, product_id: @ga.product_id, qty: @ga.qty }
    assert_redirected_to ga_path(assigns(:ga))
  end

  test "should destroy ga" do
    assert_difference('Ga.count', -1) do
      delete :destroy, id: @ga
    end

    assert_redirected_to gas_path
  end
end
