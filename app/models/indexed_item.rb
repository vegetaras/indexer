class IndexedItem < ApplicationRecord
  validates :url, presence: true, uniqueness: true
end
