class Transaction < ApplicationRecord
  belongs_to :project
  belongs_to :trans_types
  belongs_to :book
  belongs_to :supplier
  belongs_to :unit
end
