class User < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User
  after_validation :ensure_uid
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  def ensure_uid
    if self.uid.blank?
      self.uid = self.email
    end
  end
end

