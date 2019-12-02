class User < ApplicationRecord
  attr_accessor :remember_token
  
  def self.valid_user_regex
      /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  end
  
  def User.user_types
    {Super: 4, Admin: 3, Commmittee: 2, Tenant: 1}
  end
  
  before_save { email.downcase! }
  
  validates :name, presence: true
  validates :authority, presence: true
  validate  :authority_is_valid
  validates :email, presence: true, format: { with: valid_user_regex },  
                    uniqueness: true, length: { maximum: 255 }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  def is_tenant?
    self.authority == User.user_types.fetch(:Tenant) 
  end
  
  def is_super?
    self.authority == User.user_types.fetch(:Super) 
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
      
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  private
    def authority_is_valid
      unless (User.user_types).has_value?(authority)
        errors.add(:authority, "User type must be: #{User.user_types.keys}")
      end
    end
end
