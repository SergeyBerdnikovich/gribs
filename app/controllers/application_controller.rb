class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!, :except => [:welcome]

  def after_sign_in_path_for(resource)
    reports_mashrooms_path()
  end
end
