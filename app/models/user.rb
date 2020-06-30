class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  has_many :votes

  validates :name, presence: true, uniqueness: true
end
