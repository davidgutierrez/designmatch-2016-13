require 'test_helper'

class DesignTest < ActiveSupport::TestCase
 
  def setup
    @proyect = proyects(:orange)
    # This code is not idiomatically correct.
        extend ActionDispatch::TestProcess
    uploaded = fixture_file_upload('files/portrait.jpg', 'image/jpeg')

    @design = @proyect.designs.new(email: "pepe@mail.com", firstName: "pepe", lastName: "pereira", pictureOriginal: uploaded, offer: 10 )
  end

  test "should be valid" do
    assert @design.valid?
  end

  test "proyect id should be present" do
    @design.proyect_id = nil
    assert_not @design.valid?
  end
  
  test "email should be present" do
    @design.email = "   "
    assert_not @design.valid?
  end

  test "firstName should be present" do
    @design.firstName = "   "
    assert_not @design.valid?
  end

  test "lastName should be present" do
    @design.lastName = "   "
    assert_not @design.valid?
  end
  
  test "offer should be present" do
    @design.offer = nil
    assert_not @design.valid?
  end

  test "Image should be present" do
    @design.pictureOriginal = "  "
    assert_not @design.valid?
  end
  
  test "order should be most recent first" do
    assert_equal designs(:most_recent), Design.first
  end

  test "inicial state must be 'En proceso'" do
    assert_equal "En proceso", @design.state
  end

  test "deberia actualizar cuando es necesario" do
    @design.updateInProcess
    assert true
  end
end
