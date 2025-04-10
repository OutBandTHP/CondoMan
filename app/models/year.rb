class Year < ApplicationRecord
  belongs_to :project

  has_many :transactions
  has_many :ledgers
  
  validates :finyear, presence: true
  validates :ppm,     presence: false,   numericality: { greater_than: 0 }
end
