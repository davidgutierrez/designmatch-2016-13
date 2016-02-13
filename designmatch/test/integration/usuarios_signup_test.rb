require 'test_helper'

class UsuariosSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'Usuario.count' do
      post usuarios_path, usuario: { nombre:  "",
                               email: "usuario@invalid",
                               password:              "foo",
                               password_confirmation: "bar" }
    end
    assert_template 'usuarios/new'
  end
  
  test "valid signup information" do
    get signup_path
    assert_difference 'Usuario.count', 1 do
      post_via_redirect usuarios_path, usuario: { nombre:  "Usuario de Ejemplo",
                                            email: "usuario@example.com",
                                            password:              "password",
                                            password_confirmation: "password" }
    end
    assert_template 'usuarios/show'
    assert is_logged_in?
  end
end