# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create([
    {login: 'admin', password: 'admin', email: "test@email.com"},
    {login: 'user1', password: 'user1', email: "test@email.com"},
    {login: 'user2', password: 'user2', email: "test@email.com"},
    {login: 'user3', password: 'user3', email: "test@email.com"},
    {login: 'user4', password: 'user4', email: "test@email.com"},
    {login: 'user5', password: 'user5', email: "test@email.com"},
    {login: 'user6', password: 'user6', email: "test@email.com"}
])

users.each do |user|
    user.securePassword
    user.save
    leagues = League.create([
        {name: "#{user[:login]} League #1", max_contestants: 10, user: user},
        {name: "#{user[:login]} League #2", max_contestants: 10, user: user},
        {name: "#{user[:login]} League #3", max_contestants: 10, user: user}
    ])
    leagues.each do |l|
        l.save
    end
end