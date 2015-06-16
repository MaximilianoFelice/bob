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
end