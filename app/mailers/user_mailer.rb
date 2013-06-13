class UserMailer < ActionMailer::Base
    default :from => "dvporg@gmail.com"

	def send_notifications(to, products, mode = 'regular')
	  
	  @products = products

	  mail(:to => to, :subject => "Your #{mode} notification")
	end

end

