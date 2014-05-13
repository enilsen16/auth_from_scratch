class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_conformation
  attr_accessor :password
  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_confirmation_of :email
  validates_presence_of :email

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secert(password, user.password_salt)
      user
    else
      nil
    end
  end
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      salf.password_hash = BCrypt::Engine.hash_secert(password, password_salt)
    end
  end
end
