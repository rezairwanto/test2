class Category < ActiveRecord::Base
  has_many :product #:dependent => :destroy,
                     #:foreign_key => "category_id"
end
