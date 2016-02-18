require 'test_helper'

class ProyectTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    # This code is not idiomatically correct.
    @proyect = @user.proyects.build(name: "Lorem ipsum", description: "value", value: 10000)
  end

  test "should be valid" do
    assert @proyect.valid?
  end

  test "user id should be present" do
    @proyect.user_id = nil
    assert_not @proyect.valid?
  end
  
  test "name should be present" do
    @proyect.name = "   "
    assert_not @proyect.valid?
  end

  test "description should be present" do
    @proyect.description = "  "
    assert_not @proyect.valid?
  end

  test "value should be present" do
    @proyect.value = nil
    assert_not @proyect.valid?
  end

  test "value should not be negative" do
    @proyect.value = -100
    assert_not @proyect.valid?
  end
  
  test "order should be most recent first" do
    assert_equal proyects(:most_recent), Proyect.first
  end
end
