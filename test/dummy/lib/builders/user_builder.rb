class UserBuilder < Bob::Builder
  meta_build :user do |user|
    user.name = Faker::Name.first_name
    user.email = Faker::Internet.email
  end

  meta_build :customUser, User do |user, save, params|
    user.name = params[:name]
    user.email = params[:email]

    user.save! if save
  end    

  meta_build :forEachUser, User do |user|
    user.name = Faker::Name.first_name
    user.email = Faker::Internet.email
  end

  for_each :forEachUser do |user|
    user.avatar = Faker::Avatar.image
  end

  for_each :forEachUser, build: Comment, qty: 20 do |user, comment|
    comment.user = user
    comment.description = Faker::Lorem.paragraph
  end
end