# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  phone           :string(255)
#  company         :string(255)
#  college         :string(255)
#  age             :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :age, :college, :company, :email, :name, :phone, :password, :password_confirmation
  has_secure_password
   before_save { |user| user.email = email.downcase }
   before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 30 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
                    uniqueness: { case_sensitive: false }
  
  validates :phone, presence: true
  validates :company, presence: true, length: { maximum: 30 }
  validates :college, presence: true, length: { maximum: 30 }
  validates :age, presence: true, inclusion: { in: 15..120 }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
