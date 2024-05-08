class Frame < ApplicationRecord
  enum status: { inactive: 0, active: 1 }
has_many :glasses

validates :name, :stock, :price, :currency, presence: true
validates :price, uniqueness: { scope: :currency }
end