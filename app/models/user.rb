class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token
  has_many      :roles

  before_create :create_activation_digest  
  before_save   :downcase_email
  
  def User.valid_user_regex
      /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  end
   
  validates :email,    presence: true, format: { with: valid_user_regex },  
                       uniqueness: true, length: { maximum: 255 }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
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
        
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end
  
  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest:  User.digest(reset_token),
                   reset_sent_at: Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end
  
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
  
  def manages?(level, project)
      if !project.nil?
        if self.roles.find_by(project_id: project.id).nil?
          return self.roles.maximum(:authority) == Role.Sysadmin
        else   
          return self.roles.find_by(project_id: project.id).authority >= level
        end
      else
        return self.roles.maximum(:authority) >= level
      end
  end
    
  private
    def downcase_email
      self.email = email.downcase
    end
    
    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end
