class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question

  validates :body, presence: true, length: { in: 5..1500 }
  validates :user, :question, presence: true
end
