class StaticPage < ActiveRecord::Base
  attr_accessible :content, :name, :titile, :slug
end
