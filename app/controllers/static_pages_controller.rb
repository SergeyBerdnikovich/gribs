class StaticPagesController < InheritedResources::Base
	layout :resolve_layout

  def welcome
    redirect_to reports_mashrooms_path and return nil if current_user
	end

  private

  def resolve_layout
    case action_name
    when "welcome"
      "welcome"
    else
      "application"
    end
  end
end
