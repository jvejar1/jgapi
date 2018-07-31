class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_secure_token :auth_token
  before_create :set_access_token

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



  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable, :timeout_in => 3.seconds
end
