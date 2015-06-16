require 'test_helper'

class BobTest < ActiveSupport::TestCase
  
  test "building single instance" do
    user = UserBuilder.user!
    assert user.valid?
    assert user.persisted?
  end

  test "building unpersisted instance" do
    user = UserBuilder.user

    assert user.valid?
    assert !user.persisted?
  end
end
