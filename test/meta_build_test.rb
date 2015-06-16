require 'test_helper'

class MetaBuildTest < ActiveSupport::TestCase
  
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

  test "building many valid instances" do
    many_users = UserBuilder.user! qty: 50

    assert many_users.all?(&:valid?)
    assert many_users.all?(&:persisted?)
  end

  test "building many unpersisted instances" do
    many_users = UserBuilder.user qty: 50

    assert many_users.all?(&:valid?)
    assert many_users.all?{|u| !u.persisted?}
  end

  test "passing arguments to builders" do
    custom_user = UserBuilder.customUser params: {name: 'foo', email: 'bar@foobar.com'}, save: true

    assert_equal custom_user.name, 'foo', msg: "Failed user name assertion"
    assert_equal custom_user.email, 'bar@foobar.com', msg: "Failed user name assertion"
    assert custom_user.valid?, msg: "User is not valid"
    assert custom_user.persisted?, msg: "User hasn't been persisted"
  end
end