class Supplier < ApplicationRecord
  belongs_to :project

  has_many :transactions
  has_many :ledgers

  def Supplier.valid_email_regex
      /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  end

  def Supplier.valid_phone_regex
    /\d{2,3}[\-? ]\d{3} ?\d{4}/i
  end

  validates :name,     presence: true
  validates :email,    allow_nil: true, allow_blank: true, format: {with: valid_email_regex}
  validates :phone,    allow_nil: true, allow_blank: true, format: {with: valid_phone_regex}
 
end
