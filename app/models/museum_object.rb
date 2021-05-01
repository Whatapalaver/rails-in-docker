class MuseumObject < ApplicationRecord
  validates :systemNumber, presence: true, uniqueness: true
end
