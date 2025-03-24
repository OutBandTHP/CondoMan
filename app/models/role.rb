class Role < ApplicationRecord
  belongs_to :user
  belongs_to :project, optional: true

  before_save :default_user_role
  
  def Role.level
    {Sysadmin: 5, Admin: 4, Committee: 3, Owner: 2, Tenant: 1}
  end
  
  validates :authority, presence: true, inclusion: { in: 1..5,
                                        message: "חייב להיות אחד מ: #{Role.level}"}
  validates :since, presence: true
  validate  :unit_belongs_to_project
  validate  :created_after_project
  
  def Role.text(lvl)
    if lvl == nil
      lvl = 1
    end
    Role.level.to_a.at(Role.level.length-lvl).at(0).to_s
  end

  # Support query methods that fetch the value of a given type
  def Role.method_missing(calling, *params)
    authority_level = calling.capitalize.to_sym
    if Role.level[authority_level] != nil
        Role.level.fetch(:"#{authority_level}")
    else
      super
    end
  end  

  private
    def default_user_role
      self.authority ||= Role.tenant
    end

    def unit_belongs_to_project
      return if admin_level
      unless self.unit_id
        errors.add(:unit, "נא לציין מס. דירה")
        return
      end
      unless self.project.units.find(unit_id)
        errors.add(:unit, "הדירה שנבחרה אינה שייכת לפרוייקט")
      end
    end
    
    def admin_level
      !(authority == Role.owner || authority == Role.tenant)
    end
      
    def created_after_project
      return if !self.project_id
      if self.since && self.since < self.project.since 
        errors.add(:since, "תאריך התפקיד אינו יכול להיות מוקדם לתאריך הפרוייקט(#{self.project.since})")
      end  
    end
  
end
