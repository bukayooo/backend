class Address < ApplicationRecord
  validates :full_address, presence: true
  validates :bedrooms, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :bathrooms, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  scope :selected, -> { where(selected: true) }
end
