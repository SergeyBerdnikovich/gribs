class ProductsController < ApplicationController
  def index
    if params[:period_start] && params[:period_end]
      @products = Product.filter(params[:period_start].gsub('/', ''), params[:period_end].gsub('/', ''), params[:percent_threshold])
    else
      @products = []
    end
  end
end
