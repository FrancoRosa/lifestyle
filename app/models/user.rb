class User < ApplicationRecord
  has_many :votes
  has_many :articles, dependent: :destroy, foreign_key: :author 

  validates :name, presence: true, uniqueness: true, length: { in: 5..100 }
end
