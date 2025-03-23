class Notification < ApplicationRecord
  validates :text_message,  presence: true
  validates :valid_from,    presence: true
  validates :valid_to,      presence: true,
                            comparison: { greater_than: :valid_from }
end
