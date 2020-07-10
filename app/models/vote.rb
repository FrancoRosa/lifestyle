class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :article

  validates :user, presence: true, uniqueness: true
  validates :article, presence: true
  
  scope :byuser, ->(user) { where("user_id = ?",user) }
end
