# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create([
    {login: 'admin', password: 'admin', email: "pawel.mstowski@gmail.com"},
    {login: 'user1', password: 'user1', email: "test@email.com"},
    {login: 'user2', password: 'user2', email: "test@email.com"},
    {login: 'user3', password: 'user3', email: "test@email.com"},
    {login: 'user4', password: 'user4', email: "test@email.com"},
    {login: 'user5', password: 'user5', email: "test@email.com"},
    {login: 'user6', password: 'user6', email: "test@email.com"}
])

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

users.each do |user|
    user.securePassword
    user.save
    create_empty("#{user[:login]} League #1", user, 10).save
    create_empty("#{user[:login]} League #2", user, 10).save
    create_empty("#{user[:login]} League #3", user, 10).save
end

