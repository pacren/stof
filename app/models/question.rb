class Question < ApplicationRecord
  belongs_to :user

  validates :title, :body, :user_id, presence: true
  validates :title, length: { in: 10..200 }
  validates :body,  length: { in: 10..3000 }
end
