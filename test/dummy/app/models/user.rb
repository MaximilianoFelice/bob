class User < ActiveRecord::Base
  has_many :comments
  has_many :items

  #
  # => Validations
  #
  validates :items, presence: true
end
