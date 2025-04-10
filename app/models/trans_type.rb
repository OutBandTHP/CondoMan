class TransType < ApplicationRecord
  has_many   :deploy_books
  has_many   :transactions
  has_many   :ledgers
  
  validates :code,  presence: true,
                    uniqueness: true
  validates :name,  presence: true,
                    uniqueness: true
end
