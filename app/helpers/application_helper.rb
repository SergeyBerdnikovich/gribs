module ApplicationHelper

		def show_page(name, with_title = false, with_latest_update = false)
		page = StaticPage.find_by_name(name)
		page ? text = page.content : page = StaticPage.create!(:name => name)
		text.blank? ? text = "<p>There is no text available. If you are admin, please add it #{ link_to 'here', edit_admin_static_page_path(page) }.</p>" : text
		text = "Last update: #{page[:updated_at].strftime("%Y-%m-%d")} <p> #{text}" if with_latest_update
		text = "<center><h2>#{page[:title]}</h2></center> <p> #{text}" if with_latest_update

		text

	end
	def link_to_page(name)
		page = StaticPage.find_by_name(name)
		page = StaticPage.create!(:name => name) unless page
		static_page_path(page)
	end


end

