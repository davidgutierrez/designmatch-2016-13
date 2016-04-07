require 'test_helper'

class ProyectsControllerTest < ActionController::TestCase

  def setup
    @micropost = proyects(:orange)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Proyect.count' do
      post :create, proyect: { name: "Lorem ipsum", description: "Lorem ipsum", value: 100 }
    end
    assert_redirected_to login_url
  end

#  test "should redirect destroy when not logged in" do
#    assert_no_difference 'Proyect.count' do
#      delete :destroy, id: @proyect
#    end
#    assert_redirected_to login_url
# end
  
  test "should redirect destroy for wrong proyect" do
    log_in_as(users(:michael))
    proyect = proyects(:ants)
    assert_no_difference 'Proyect.count' do
      delete :destroy, id: proyect
    end
    assert_redirected_to root_url
  end
end