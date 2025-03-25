class Project < ApplicationRecord
  before_save { admin.downcase! }
  before_save { email.downcase! }
  
  has_many :buildings
  has_many :units
  has_many :roles
  has_many :notifications  
  
  validates :name,         presence: true, length: { maximum: 50 }, 
                           uniqueness: true
  validates :admin,        presence: true, format: { with: User.valid_user_regex }
  validates :address,      presence: true, length: { maximum: 255 }
  validates :email,        presence: true, format: { with: User.valid_user_regex },  
                           uniqueness: true
  validates :no_buildings, numericality: { greater_than: 0 }
  validates :no_units,     numericality: { greater_than: 0 }

end
