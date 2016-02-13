require 'test_helper'

class UsuariosLoginTest < ActionDispatch::IntegrationTest

  def setup
    @usuario = usuarios(:michael)
  end
  
  test "login con informacion invalida" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: "", password: "" }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
  
  test "login with valid information followed by logout" do
    get login_path
    post login_path, session: { email: @usuario.email, password: 'password' }
    assert is_logged_in?
    assert_redirected_to @usuario
    follow_redirect!
    assert_template 'usuarios/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", usuario_path(@usuario)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", usuario_path(@usuario), count: 0
  end
  
end