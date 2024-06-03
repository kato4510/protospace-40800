class Comment < ApplicationRecord
  validates :content, presence: true
  validates :user, presence: true
  validates :prototype, presence: true

  belongs_to :user
  belongs_to :prototype
end