class Book < ApplicationRecord
  belongs_to :project
  has_many   :children, class_name: "Group", foreign_key: "group_id"
  has_many   :deploy_book, as: :book_neg
#  has_many   :deploy_book, as: :book_neg        should have worked?
  
  belongs_to :parent, class_name: "Group", optional: true
  
  def Book.group
    {מאזן: 'מ', תזרים: 'ת'}
  end
  
  validates :name, presence: true
  validates :kind, presence: true, inclusion: { in: ['מ', 'ת'],
                                   message: "חייב להיות אחד מ: #{Book.group}"}
  
end
