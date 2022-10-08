seller1 = User.find_or_initialize_by(username: 'JimmySeller')
seller2 = User.find_or_initialize_by(username: 'JaneSeller')
seller3 = User.find_or_initialize_by(username: 'RonnySeller')

[seller1, seller2, seller3].each do |seller|
  seller.password = 'q123q123'
  seller.role = 'seller'
  seller.save!
  puts "#{seller.role} - #{seller.username} saved!"
end

product1_1 = seller1.products.find_or_initialize_by(name: 'JimmySeller Product 1')
product1_2 = seller1.products.find_or_initialize_by(name: 'JimmySeller Product 2')
product1_3 = seller1.products.find_or_initialize_by(name: 'JimmySeller Product 3')
product2_1 = seller2.products.find_or_initialize_by(name: 'JaneSeller Product 1')
product2_2 = seller2.products.find_or_initialize_by(name: 'JaneSeller Product 2')
product2_3 = seller2.products.find_or_initialize_by(name: 'JaneSeller Product 3')
product3_1 = seller3.products.find_or_initialize_by(name: 'RonnySeller Product 1')
product3_2 = seller3.products.find_or_initialize_by(name: 'RonnySeller Product 2')
product3_3 = seller3.products.find_or_initialize_by(name: 'RonnySeller Product 3')

[product1_1, product1_2, product1_3, product2_1, product2_2, product2_3, product3_1, product3_2, product3_3].each do |product|
  product.cost = [30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150].sample
  product.amount_available = (10..25).to_a.sample
  product.save!
  puts "#{product.name} saved!"
end
