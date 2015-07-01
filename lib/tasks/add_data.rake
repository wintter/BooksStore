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
      image = 'img_book' << rand(1..10) << '.png'
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

  task :address => :environment do
    billing_address = Faker::Address.street_name
    shipping_address = Faker::Address.street_address
    user_id = 11
    Address.create!(billing_address: billing_address, shipping_address: shipping_address,
                    user_id: user_id)
  end

  task :credit_card => :environment do
    2.times do
      number = Faker::Business.credit_card_number
      CVV_card = rand(100..999)
      expiration_month = Time.now
      expiration_year = Time.now
      firstname = 'Bob'
      lastname = 'Boba'
      user_id = 11
      CreditCard.create!(number: number, CVV: CVV_card, expiration_month: expiration_month,
                         expiration_year: expiration_year, first_name: firstname,
                         last_name: lastname, user_id: user_id)
    end
  end

  task :wish_list => :environment do
    30.times do
      user_id = rand(1..11)
      book_id = rand(1..11)
      user = User.find(user_id)
      user.books.push Book.find(book_id)
    end
  end

end
