class User < ApplicationRecord
  def self.valid_user_regex
      /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  end
  
  def User.user_types
    {Super: 4, Admin: 3, Commmittee: 2, Tenant: 1}
  end
  
  before_save { email.downcase! }
  
  validates :authority, presence: true
  validate :authority_is_valid
  validates :email, presence: true, format: { with: valid_user_regex },  
                    uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  
  private
    def authority_is_valid
      unless (User.user_types).has_value?(authority)
        errors.add(:authority, "User type must be: #{User.user_types.keys}")
      end
    end
end
