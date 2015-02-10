class User < ActiveRecord::Base
  attr_accessible :access, :email, :name, :type_like, :password, :password_digest, :password_confirmation


  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 4 }, allow_blank: true


  def initalize(attribute ={})
    @name = attributes[:@name]
    @email = attributes[:email]

  end

  def formetted_user
    "#{@name} <#{@email}>"
  end
end
