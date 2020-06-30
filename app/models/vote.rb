class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :article

  validates :user, presence: true, uniqueness: true
  validates :article, presence: true
end
