class Category < ApplicationRecord
  has_and_belongs_to_many :articles

  validates :name, presence: true, length: { in: 5..20}
  validates :priority, presence: true
end
