class Quote < ApplicationRecord
  belongs_to :user
  belongs_to :book
  
  validates :sentence, presence: true, length: { maximum: 100 }
  
end
