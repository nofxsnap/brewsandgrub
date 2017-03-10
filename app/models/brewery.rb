class Brewery < ApplicationRecord
  belongs_to :contact, required: false
  belongs_to :menu, required: false
end
