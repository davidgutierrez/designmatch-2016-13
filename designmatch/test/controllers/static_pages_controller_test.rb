require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  
  def setup
    @base_title = "Designmatch"
  end
  
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "#{@base_title}"
  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", "Ayuda | #{@base_title}"
  end

  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", "Acerca de | #{@base_title}"
  end

  test "should get contact" do
    get :contact
    assert_response :success
    assert_select "title", "Contactenos | #{@base_title}"
  end
end
