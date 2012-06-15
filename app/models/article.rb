class Article < ActiveRecord::Base
  belongs_to :user
  scope :since, lambda {|time_ago| where("created_at >= ?", time_ago).order("created_at DESC").limit(3) }
  has_many :comment, :dependent => :destroy,
                     :foreign_key => :article_id

end
