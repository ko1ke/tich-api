class User < ApplicationRecord
  has_one :portfolio
  validates :uid, presence: true, uniqueness: true
end
