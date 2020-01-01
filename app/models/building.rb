class Building < ApplicationRecord
  belongs_to :project
  
  validates :id_code, presence: true
end
