class User < ApplicationRecord
  attr_accessor :remember_token
  
  before_save :default_user_type
  before_save { email.downcase! }
  
  def User.valid_user_regex
      /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  end
  
  def User.user_types
    {Sysadmin: 5, Admin: 4, Committee: 3, Owner: 2, Tenant: 1}
  end
  
  def method_missing(calling, *params)
    if /is_(.+)\?/ !~ calling
      if /at_(.+)_level\?/ !~ calling
        super
      else
        authority_level = $1.capitalize
        self.authority >= User.user_types.fetch(:"#{authority_level}")
      end
    else
      authority_level = $1.capitalize
      return eval("self.authority == User.user_types.fetch(:#{authority_level})")
    end   
  end
  
  def User.method_missing(calling, *params)
    authority_level = calling.capitalize.to_sym
    if User.user_types[authority_level] != nil
        User.user_types.fetch(:"#{authority_level}")
    else
      super
    end
  end
   
  validates :name,     presence: true
  validates :email,    presence: true, format: { with: valid_user_regex },  
                       uniqueness: true, length: { maximum: 255 }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  def manages?(level)
    if level == User.sysadmin
      true
    else
      self.authority > level
    end
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
    def default_user_type
      self.authority ||= User.tenant
    end
end
