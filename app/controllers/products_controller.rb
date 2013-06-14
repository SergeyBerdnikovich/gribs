class ProductsController < ApplicationController
  def index
    @products = Product.page(params[:page])

    respond_to do |format|
      format.html
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end
end
