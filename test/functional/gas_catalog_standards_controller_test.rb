require 'test_helper'

class GasCatalogStandardsControllerTest < ActionController::TestCase
  setup do
    @gas_catalog_standard = gas_catalog_standards(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gas_catalog_standards)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gas_catalog_standard" do
    assert_difference('GasCatalogStandard.count') do
      post :create, gas_catalog_standard: { extended_description: @gas_catalog_standard.extended_description, item_id: @gas_catalog_standard.item_id, manufacturer: @gas_catalog_standard.manufacturer, manufacturer_item_id: @gas_catalog_standard.manufacturer_item_id, msrp: @gas_catalog_standard.msrp, product_name: @gas_catalog_standard.product_name, short_description: @gas_catalog_standard.short_description, stock_status: @gas_catalog_standard.stock_status, upc_or_ean_id: @gas_catalog_standard.upc_or_ean_id }
    end

    assert_redirected_to gas_catalog_standard_path(assigns(:gas_catalog_standard))
  end

  test "should show gas_catalog_standard" do
    get :show, id: @gas_catalog_standard
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gas_catalog_standard
    assert_response :success
  end

  test "should update gas_catalog_standard" do
    put :update, id: @gas_catalog_standard, gas_catalog_standard: { extended_description: @gas_catalog_standard.extended_description, item_id: @gas_catalog_standard.item_id, manufacturer: @gas_catalog_standard.manufacturer, manufacturer_item_id: @gas_catalog_standard.manufacturer_item_id, msrp: @gas_catalog_standard.msrp, product_name: @gas_catalog_standard.product_name, short_description: @gas_catalog_standard.short_description, stock_status: @gas_catalog_standard.stock_status, upc_or_ean_id: @gas_catalog_standard.upc_or_ean_id }
    assert_redirected_to gas_catalog_standard_path(assigns(:gas_catalog_standard))
  end

  test "should destroy gas_catalog_standard" do
    assert_difference('GasCatalogStandard.count', -1) do
      delete :destroy, id: @gas_catalog_standard
    end

    assert_redirected_to gas_catalog_standards_path
  end
end
