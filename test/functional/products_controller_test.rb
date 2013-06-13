require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, product: { extended_description: @product.extended_description, height: @product.height, images: @product.images, item_id: @product.item_id, length: @product.length, manufacturer: @product.manufacturer, manufacturer_item_id: @product.manufacturer_item_id, product_name: @product.product_name, short_description: @product.short_description, upc_or_ean_id: @product.upc_or_ean_id, weight: @product.weight, width: @product.width }
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    get :show, id: @product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product
    assert_response :success
  end

  test "should update product" do
    put :update, id: @product, product: { extended_description: @product.extended_description, height: @product.height, images: @product.images, item_id: @product.item_id, length: @product.length, manufacturer: @product.manufacturer, manufacturer_item_id: @product.manufacturer_item_id, product_name: @product.product_name, short_description: @product.short_description, upc_or_ean_id: @product.upc_or_ean_id, weight: @product.weight, width: @product.width }
    assert_redirected_to product_path(assigns(:product))
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, id: @product
    end

    assert_redirected_to products_path
  end
end
