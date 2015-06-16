class UserBuilder < Bob::Builder
  meta_build :user do |user|
    user.name = Faker::Name.first_name
    user.email = Faker::Internet.email
  end
end