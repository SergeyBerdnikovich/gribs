require 'test_helper'

class GasInventoryStandardsControllerTest < ActionController::TestCase
  setup do
    @gas_inventory_standard = gas_inventory_standards(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gas_inventory_standards)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gas_inventory_standard" do
    assert_difference('GasInventoryStandard.count') do
      post :create, gas_inventory_standard: { active_status: @gas_inventory_standard.active_status, item_id: @gas_inventory_standard.item_id, qty_available: @gas_inventory_standard.qty_available, stock_status: @gas_inventory_standard.stock_status }
    end

    assert_redirected_to gas_inventory_standard_path(assigns(:gas_inventory_standard))
  end

  test "should show gas_inventory_standard" do
    get :show, id: @gas_inventory_standard
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gas_inventory_standard
    assert_response :success
  end

  test "should update gas_inventory_standard" do
    put :update, id: @gas_inventory_standard, gas_inventory_standard: { active_status: @gas_inventory_standard.active_status, item_id: @gas_inventory_standard.item_id, qty_available: @gas_inventory_standard.qty_available, stock_status: @gas_inventory_standard.stock_status }
    assert_redirected_to gas_inventory_standard_path(assigns(:gas_inventory_standard))
  end

  test "should destroy gas_inventory_standard" do
    assert_difference('GasInventoryStandard.count', -1) do
      delete :destroy, id: @gas_inventory_standard
    end

    assert_redirected_to gas_inventory_standards_path
  end
end
