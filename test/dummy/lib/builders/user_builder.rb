class UserBuilder < Bob::Builder
  meta_build :user do |user|
    user.name = Faker::Name.first_name
    user.email = Faker::Internet.email
    user.items << Item.create!
  end

  meta_build :customUser, User do |user, save, params|
    user.name = params[:name]
    user.email = params[:email]
    user.items << Item.create!

    user.save! if save
  end    

  meta_build :forEachUser, User do |user|
    user.name = Faker::Name.first_name
    user.email = Faker::Internet.email
    user.items << Item.create!
  end

  for_each :forEachUser do |user|
    user.avatar = Faker::Avatar.image
  end

  for_each :forEachUser, build: Comment, qty: 20 do |user, comment|
    comment.user = user
    comment.description = Faker::Lorem.paragraph
  end

  meta_build :randomUser, User do |user|
    user.name = Faker::Name.first_name
    user.email = Faker::Internet.email
  end

  for_each :randomUser, build: Item, qty: 5, rnd_qty: true, min: 1 do |user, item|
    item.user = user
    item.description = Faker::Lorem.sentence
    user.items << item
  end
end