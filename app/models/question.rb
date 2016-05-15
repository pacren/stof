class Question < ApplicationRecord
  belongs_to :user

  has_many :answers, dependent: :destroy

  validates :user, presence: true
  validates :title, length: { in: 10..200 }, presence: true
  validates :body,  length: { in: 10..3000 }, presence: true
end
