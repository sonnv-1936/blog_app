class Entry < ApplicationRecord
  belongs_to :user

  has_many :comments

  validates :title, presence: true
  validates :body, presence: true

  scope :latest, ->{order created_at: :desc}
end
