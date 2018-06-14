class Game < ApplicationRecord
  belongs_to :league, :class_name => 'League'
end
