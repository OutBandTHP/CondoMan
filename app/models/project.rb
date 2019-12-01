class Project < ApplicationRecord
  before_save { admin.downcase! }
  before_save { email.downcase! }
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :admin, presence: true, format: { with: User.valid_user_regex }
  validates :address, presence: true, length: { maximum: 255 }
  validates :email, presence: true, format: { with: User.valid_user_regex },  
                    uniqueness: true
end
