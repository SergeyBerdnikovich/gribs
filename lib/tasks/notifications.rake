task :notifications => :environment do
	puts "Pulling new notifications..."
	Notification.all.each do |notification|
		if notification.notification_mode.id == 1
			yestrerday = Time.now - 1.day
			notify = false # to not notify when everything disable
			
			if notification.start_qty_notification == true
				begin_qty = notification.start_qty
				begin_qty = 0 if begin_qty.nil?
				notify = true
			end
			if notification.treshhold_notification == true
				treshhold = notification.treshhold
				treshhold = 0 if treshhold.nil?
				notify = true
			end
			if notify == true
				p "processing notification"
				products = Product.filter(1,Time.now.strftime("%Y%m%d"), yestrerday.strftime("%Y%m%d"), begin_qty , treshhold )
				notification.emails.split(/[,; ]/).each do |email|
					p email
					UserMailer.send_notifications(email, products, notification.notification_mode.name).deliver
				end
			end
		end
	end
	puts "done."
end