class ReportsController < ApplicationController
	def mushrooms
		if params[:period_start].blank? or params[:period_end].blank?
			@products = []	
			flash.now[:error] = "Please choose first and last days"		
		else
			@products = Product.filter(params[:source_id],params[:period_start].gsub(/[^0-9]/, ''), params[:period_end].gsub(/[^0-9]/, ''), params[:begin_qty], params[:percent_threshold],params[:cost])

		end
		respond_to do |format|
			format.html
			format.csv { send_data Product.to_csv(params[:source_id],params[:period_start].gsub(/[^0-9]/, ''), params[:period_end].gsub(/[^0-9]/, ''), params[:begin_qty], params[:percent_threshold]) }
			format.xls { send_data @products.to_csv(col_sep: "\t") }
		end
	end

	def days_drop

		if params[:start_date].blank?
			@products = []	
			flash.now[:error] = "Please choose start_date"		
		else
			@source = Source.find(params[:source_id])
			@products = Product.days_drop(params[:start_date].gsub(/[^0-9]/, ''),params[:days].gsub(/[^0-9]/, ''), params[:trashhold].gsub(/[^\.\,0-9]/, ''), @source)
			@products.each_with_index  do |prod,i|
				@products[i][0] = Product.where("id = ?", prod[1]).first

			end
		end
		respond_to do |format|
			format.html
			format.csv { send_data Product.to_csv(params[:source_id],params[:period_start].gsub(/[^0-9]/, ''), params[:period_end].gsub(/[^0-9]/, ''), params[:begin_qty], params[:percent_threshold]) }
			format.xls { send_data @products.to_csv(col_sep: "\t") }
		end


	end

end
