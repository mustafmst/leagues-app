class League < ApplicationRecord
  belongs_to :user, :class_name => 'User'
  has_many :contestants, :class_name => 'Contestant'

  def is_user_sign_in(user_id)
    self.contestants.each do |c|
        if c.user[:id] == user_id
            return true
        end
    end
    return false
  end

  def is_full
    return self[:max_contestants] == self.contestants.count
  end
end
