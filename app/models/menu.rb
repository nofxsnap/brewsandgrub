class Menu < ApplicationRecord
  belongs_to :owner, polymorphic: true
end
