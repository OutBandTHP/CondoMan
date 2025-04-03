class Year < ApplicationRecord
  belongs_to :project
  
  validates :finyear, presence: true
  validates :ppm,     presence: false,   numericality: { greater_than: 0 }
end
