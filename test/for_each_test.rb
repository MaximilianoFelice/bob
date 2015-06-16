require 'test_helper'

class ForEachTest < ActiveSupport::TestCase
  
  test "creating avatar for each user" do
    user = UserBuilder.forEachUser!

    assert !user.avatar.blank?
    assert user.persisted?
  end

  test "comment instantiation" do
    user = UserBuilder.forEachUser!

    assert_equal user.comments.count, 20
    assert user.persisted?
  end

end