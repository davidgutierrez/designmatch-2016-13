require 'test_helper'

class ProyectsInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "proyect interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    # Invalid submission
    assert_no_difference 'Proyect.count' do
      post proyects_path, proyect: { name: "", description: "", value:0 }
    end
    assert_select 'div#error_explanation'
    # Valid submission
    name = "This proyect really ties the room together"
    description = "This proyect really works for me"
    value = 1000
    assert_difference 'Proyect.count', 1 do
      post proyects_path, proyect: { name: name, description: description, value: value }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match name, response.body
    # Delete a post.
    assert_select 'a', text: 'delete'
    first_proyect = @user.proyects.paginate(page: 1).first
    assert_difference 'Proyect.count', -1 do
      delete proyect_path(first_proyect)
    end
    # Visit a different user.
    get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0
  end
end
