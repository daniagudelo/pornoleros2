class Scene < ApplicationRecord
  
  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 5, maximum: 500 }
  
end