class Contestant < ApplicationRecord
  belongs_to :league, :class_name => 'League'
  belongs_to :user, :class_name => 'User'
end
