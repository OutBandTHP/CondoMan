class Transaction < ApplicationRecord
  has_many   :ledgers

  belongs_to :project
  belongs_to :trans_type
  belongs_to :book
end
