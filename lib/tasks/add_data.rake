namespace :db_populate do

  task :authors => :environment do
    5.times do
      firstname = Faker::Internet.user_name
      lastname = Faker::Internet.user_name
      biography = Faker::Lorem.paragraph(5)
      Author.create!(firstname: firstname,
                     lastname: lastname,
                     biography: biography)
    end
  end

  task :books => :environment do
    100.times do
      title = Faker::Commerce.product_name
      description = Faker::Lorem.paragraph(5)
      price = Faker::Commerce.price
      in_stock = Faker::Number.number(2)
      image = 'img_book' << rand(1..10).to_s << '.png'
      Book.create!(title: title,
                   description: description,
                   price: price, image: image,
                   count_pages: rand(1..1000), publication_date: Time.now,
                   in_stock: in_stock, author_id: rand(1..5), category_id: rand(1..5))
    end
  end

  task :categories => :environment do
    category_name = ['Children\'s books‎', 'Bibliographies of cities‎', 'Great books',
                     'Franz Kafka works', 'The Simpsons books']
    5.times do |n|
      title = category_name[n]
      Category.create!(title: title)
    end
  end

  task :users => :environment do
    10.times do
      name = Faker::Name.first_name
      email = Faker::Internet.email
      password = Faker::Internet.password
      User.create!(name: name, email: email, password: password, password_confirmation: password)
    end
    name = 'admin'
    email = 'i@i.ua'
    password = '123456'
    User.create!(name: name, email: email, password: password, password_confirmation: password, admin: true)
  end

  task :ratings => :environment do
    30.times do
      review = Faker::Lorem.paragraph(3)
      rating_number = Faker::Number.digit
      user_id = rand(1..11)
      book_id = rand(1..10)
      approve = [true, false].sample
      Rating.create!(review: review, rating_number: rating_number, user_id: user_id,
                     book_id: book_id, approve: approve)
    end
  end

  task :wish_list => :environment do
    30.times do
      user_id = rand(1..11)
      book_id = rand(1..11)
      WishList.create(user: user_id, book: book_id)
    end
  end

  task :order_states => :environment do
    possible_states = ['in progress', 'in queue', 'in delivery', 'delivered', 'canceled']
    5.times do |i|
      name_state = possible_states[i]
      OrderState.create!(state: name_state)
    end
  end

end

task :db_populate do
  Rake::Task['db_populate:authors'].invoke
  Rake::Task['db_populate:categories'].invoke
  Rake::Task['db_populate:books'].invoke
  Rake::Task['db_populate:users'].invoke
  Rake::Task['db_populate:ratings'].invoke
  Rake::Task['db_populate:address'].invoke
  Rake::Task['db_populate:credit_card'].invoke
  Rake::Task['db_populate:wish_list'].invoke
end