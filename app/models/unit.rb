class Unit < ApplicationRecord
  belongs_to :project
  
  validates :number, presence: true
  validates :since, presence: true
  validate :created_after_project
  
  private
    def created_after_project
      if self.since < self.project.since
        errors.add(:since, "Can't be before project's Since date")
      end
    end
end
