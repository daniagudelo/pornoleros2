class Scene < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 5, maximum: 500 }
  validates :user_id, presence: true
  
  default_scope -> { order(updated_at: :desc) }
  
end