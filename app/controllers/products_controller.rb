class ProductsController < ApplicationController
  def index
    
      @products = Product.page(params[:page])
    
    respond_to do |format|
      format.html
    end

  end
end
