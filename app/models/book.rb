class Book < ApplicationRecord
  
  validates :title, presence: true, length: { maximum: 50 }
  validates :author, presence: true, length: { maximum: 50 }
  
  has_many :quotes
end
