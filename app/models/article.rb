class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, :text, presence: true
end
