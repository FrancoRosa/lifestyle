class Category < ApplicationRecord
  has_and_belongs_to_many :articles

  validates :name, presence: true, length: { in: 5..20 }
  validates :priority, presence: true
  scope :top, ->(length) { all.order(priority: :asc).limit(length) }
  scope :bydate, ->(id) { find(id).articles.order(created_at: :desc).limit(4) }
end
