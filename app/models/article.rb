class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :title, :text, presence: true

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
