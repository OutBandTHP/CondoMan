class TransType < ApplicationRecord
  validates :code,  presence: true,
                    uniqueness: true
  validates :name,  presence: true,
                    uniqueness: true
end
