class Event < ApplicationRecord
  has_many :item_references, as: :item_referenceable
end
