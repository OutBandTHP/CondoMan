class Project < ApplicationRecord
  before_save { admin.downcase! }
  before_save { email.downcase! }
  
  has_many :years
  has_many :buildings
  has_many :units
  has_many :notifications  
  has_many :roles
  has_many :users,         through: :roles
  has_many :suppliers
  has_many :transactions
  has_many :ledgers
  
  validates :name,         presence: true, length: { maximum: 50 }, 
                           uniqueness: true
  validates :admin,        presence: true, format: { with: User.valid_user_regex }
  validates :address,      presence: true, length: { maximum: 255 }
  validates :email,        presence: true, format: { with: User.valid_user_regex },  
                           uniqueness: true
  validates :no_buildings, numericality: { greater_than: 0 }
  validates :no_units,     numericality: { greater_than: 0 }

  def set_month
    newmonth = self.current_month.advance(months: 1)
    update_columns(current_month: newmonth)
  end

  def set_reference
    newrefin = self.refin.to_i + 1
    update_columns(refin: newrefin)
    return sprintf("%05d", newrefin)
  end

  def get_value(which)
    return eval("self.#{which}")
  end
end
