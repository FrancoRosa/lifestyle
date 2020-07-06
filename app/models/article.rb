class Article < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_and_belongs_to_many :categories, dependent: :destroy
  has_many :votes, dependent: :destroy

  validates :author_id, presence: true
  validates :title, presence: true, length: { in: 5..100 }
  validates :text, presence: true, length: { in: 5..1000 }
  validates :image, presence: true

  has_one_attached :image
  scope :latest, -> { all.order(created_at: :desc).first }
  scope :rank, -> { joins(:votes).group('article_id').count }
end
