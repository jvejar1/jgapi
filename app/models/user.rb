class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_secure_token :auth_token
  before_create :set_access_token
 def self.roles
   {1=>User.ADMIN,2=>User.EVALUATOR}
 end
  def self.ADMIN
    "Admin"
  end
  def self.EVALUATOR

    "Evaluator"
  end



  @@permissions={1=>"Admin Users",2=>"View Results",3=>"Admin Schools",4=>"Admin Courses"}

  def can_admin_users?
    if User.roles[self.role]==User.ADMIN
      return true
    else
      return false
    end
  end

  def can_admin_schools?
    if User.roles[self.role]==User.ADMIN
      return true
    else
      return false
    end
  end
  def can_admin_courses?
    if User.roles[self.role]==User.ADMIN
      return true
    else
      return false
    end
  end
  private
  def set_access_token
    self.auth_token = generate_token
  end

  def generate_token
    loop do
      token = SecureRandom.hex(10)
      break token unless User.where(auth_token:token).exists?
    end
  end



  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable
end
