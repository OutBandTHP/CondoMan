class TransType < ApplicationRecord
  has_many   :deploy_book
  
  validates :code,  presence: true,
                    uniqueness: true
  validates :name,  presence: true,
                    uniqueness: true
end
