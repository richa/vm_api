seller1 = User.find_or_initialize_by(username: 'JimmySeller')
seller2 = User.find_or_initialize_by(username: 'JaneSeller')
seller3 = User.find_or_initialize_by(username: 'RonnySeller')

[seller1, seller2, seller3].each do |seller|
  seller.password = 'q123q123'
  seller.role = 'seller'
  seller.save!
  puts "#{seller.role} - #{seller.username} saved!"
end
