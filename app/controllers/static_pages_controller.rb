class StaticPagesController < InheritedResources::Base
	layout :resolve_layout

  def welcome
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
