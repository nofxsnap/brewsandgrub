class Brewery < ApplicationRecord
  belongs_to :contact
  belongs_to :menu
end
