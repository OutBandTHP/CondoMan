class Ledger < ApplicationRecord
  belongs_to :project
  belongs_to :book
  belongs_to :trans_type
end
