class User < ActiveRecord::Base
  has_many :article, :dependent => :destroy
                     #:foreign_key => "user_id"
  has_many :comment, :dependent => :destroy
                     #:foreign_key => "user_id"
  has_many :product, :dependent => :destroy
                     #:foreign_key => "user_id"

  attr_accessor :password
  before_save :encrypt_password

  validates :password, :presence => {:on => :create},
                       :confirmation => true
  
  validates :email, :presence => true,
                    :length => {:minimum => 1, :maximum => 254},
                    :uniqueness => true
  def encrypt_password
    if password.present?
       self.password_salt = BCrypt::Engine.generate_salt
       self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def self.authenticate(email, password)
  user = find_by_email(email)
  if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
    user
  else
    nil
  end
  end

  def show_full_name
    "#{self.first_name} #{self.last_name}"
  end

  def is_admin?
    if self.email == 'admin@admin.com'
      true
    else
      false
    end
  end 

  
end
