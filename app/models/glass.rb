class Glass < ApplicationRecord
  belongs_to :user
  belongs_to :frame
  belongs_to :lens  #len has a 1 pair (2 lenses), so So I considered it as a belongs not as has_many
  
end




