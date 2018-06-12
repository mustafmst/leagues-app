class League < ApplicationRecord
  belongs_to :user, :class_name => 'User'
  has_many :contestants, :class_name => 'Contestant'
end
