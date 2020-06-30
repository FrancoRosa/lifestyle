class Article < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_and_belongs_to_many :categories
  has_many :votes

  validates :author_id, presence: true
  validates :title, presence: true, length: { in: 5..20 }
  validates :text, presence: true, length: { in: 5..500 }
end
