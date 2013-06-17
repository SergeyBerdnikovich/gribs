class ReportsController < ApplicationController
	def mushrooms
		if params[:period_start] && params[:period_end]
			@products = Product.filter(params[:source_id],params[:period_start].gsub(/[^0-9]/, ''), params[:period_end].gsub(/[^0-9]/, ''), params[:begin_qty], params[:percent_threshold],params[:cost])
		else
			@products = []
		end
		respond_to do |format|
			format.html
			format.csv { send_data Product.to_csv(params[:source_id],params[:period_start].gsub(/[^0-9]/, ''), params[:period_end].gsub(/[^0-9]/, ''), params[:begin_qty], params[:percent_threshold]) }
			format.xls { send_data @products.to_csv(col_sep: "\t") }
		end

	end

end
