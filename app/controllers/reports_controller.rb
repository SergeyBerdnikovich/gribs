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
			if params[:cost]
				cost = params[:cost].gsub(/[^0-9]/, '').to_i
			else
				cost = 0
			end
			cost = 0 if cost == nil
			if params[:qty]
				qty = params[:qty].gsub(/[^0-9]/, '').to_i
			else
				qty = 0
			end
			qty = 0 if qty == nil

			if params[:threshold]
				threshold = params[:threshold].gsub(/[^0-9\-]/, '').to_i
			else
				threshold = 0
			end
			threshold = 0 if threshold == nil



			@source = Source.find(params[:source_id])
			@products = Product.days_drop(params[:start_date].gsub(/[^0-9]/, ''),params[:days].gsub(/[^0-9]/, ''), threshold, @source,qty,cost)
			@products.each_with_index  do |prod,i|
				@products[i][0] = nil
				prod = Product.where("id = ?", prod[1]).first
				if prod
					if prod.cost
					if prod.cost > cost
						@products[i][0] = prod
						
					end
				end
				end
			end
		end
		respond_to do |format|
			format.html
			format.csv { send_data Product.to_csv(params[:source_id],params[:period_start].gsub(/[^0-9]/, ''), params[:period_end].gsub(/[^0-9]/, ''), params[:begin_qty], params[:percent_threshold]) }
			format.xls { send_data @products.to_csv(col_sep: "\t") }
		end


	end

end
