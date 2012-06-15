class Product < ActiveRecord::Base
  belongs_to :category
  scope :since, lambda {|time_ago| where("created_at >= ?", time_ago).order("created_at DESC").limit(6) }

end
