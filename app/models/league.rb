class League < ApplicationRecord
  belongs_to :user, :class_name => 'User'
  has_many :contestants, :class_name => 'Contestant'
  has_many :games, :class_name => 'Game'

  def destroy_all
    self.contestants.each do |c|
      c.destroy
    end
    self.games.each do |g|
      g.destroy
    end
    self.destroy
  end

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

  def can_user_register(user_id)
    return !self.is_closed &&  
      user_id != self.user.id &&
      !self.is_user_sign_in(user_id) && 
      !self.is_full 
  end

  def create_empty(name, user, max_contestants)
    new_league = League.create({
      :name => name,
      :user => user,
      :max_contestants => max_contestants,
      :is_closed => false,
      :is_finished => false,
      :games_left => nil
    })
    return new_league
  end
end
