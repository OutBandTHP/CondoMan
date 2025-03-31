class DeployBook < ApplicationRecord
  belongs_to :project
  belongs_to :trans_type
#  belongs_to :book_neg,         class_name: 'Book'
#  belongs_to :book_pos        should have worked?

  validates :trans_type_id, presence: true
  validates :book_neg_id,   presence: true
  validates :book_pos_id,   presence: true,
                            comparison: {other_than: :book_neg_id }

  # Support query of books to be deployed
  def DeployBook.get_deployment(pr_id, tr_id)
    TransType.find_by(code: tr_id).deploy_book.where(project_id: pr_id).pluck(:trans_type_id, :book_neg_id, 0) +
    TransType.find_by(code: tr_id).deploy_book.where(project_id: pr_id).pluck(:trans_type_id, 0, :book_pos_id)
  end
end