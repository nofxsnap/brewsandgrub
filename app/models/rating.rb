class Rating < ApplicationRecord
  belongs_to :owner, polymorphic: true
end
