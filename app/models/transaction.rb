class Transaction < ApplicationRecord
  has_many   :ledgers
  has_many   :children, class_name: "Process", foreign_key: "transactions_id"
  
  belongs_to :parent, class_name: "Process", optional: true
  belongs_to :project
  belongs_to :trans_type
end
