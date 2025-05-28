Match.destroy_all
Member.destroy_all

5.times do |i|
  Member.create!(
    name: "Player #{i + 1}",
    email: "player#{i + 1}@example.com",
    birthday: Date.new(1990, 1, i + 1),
    rank: i + 1,
    games_played: 0
  )
end

puts "Seeded 5 members."
