class Address < ApplicationRecord
  scope :selected, -> { where(selected: true) }
end
