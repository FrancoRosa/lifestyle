class Article < ApplicationRecord
  belongs_to :autor
  belongs_to :category
end
