class Unit < ApplicationRecord
  belongs_to :project
  has_many :roles
  has_many :transactions
  has_many :ledgers
  
  validates :number, presence: true
  validates :since,  presence: true
  validates :area,   presence: false,   numericality: { greater_than: 0 }
  validate  :belongs_to_building
  validate  :created_after_project
  
  private
    def belongs_to_building
      return if building == nil
      unless self.project.buildings.find(building)
        errors.add(:building, "הבניין שנבחר אינו שייך לפרוייקט")
      end
    end
      
    def created_after_project
      if self.since < self.project.since 
        errors.add(:since, "הדירה אינה יכולה להיות פעילה לפני מועד פעילות הפרוייקט(#{self.project.since})")
      end  
    end
end
