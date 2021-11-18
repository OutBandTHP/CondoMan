class Unit < ApplicationRecord
  belongs_to :project
  
  validates :number, presence: true
  validates :since, presence: true
  validate  :belongs_to_building
  validate  :created_after_project
  
  private
    def belongs_to_building
      return if building == nil
      unless self.project.buildings.find(building)
        errors.add(:building, "This building does't belong to the project")
      end
    end
      
    def created_after_project
      if self.since < self.project.since 
        errors.add(:since, "This unit can't be occupied before the project(#{self.project.since})")
      end  
    end
end
