require 'test_helper'

class UsuarioTest < ActiveSupport::TestCase

  def setup
    @usuario = Usuario.new(nombre: "Usuario de Ejemplo", email: "usuario@ejemplo.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  test "debe ser valido" do
    assert @usuario.valid?
  end
  
  test "El nombre debe estar presente" do
    @usuario.nombre = "     "
    assert_not @usuario.valid?
  end

  test "El email debe estar presente" do
    @usuario.email = "     "
    assert_not @usuario.valid?
  end
  
  test "nombre no debe ser muy largo" do
    @usuario.nombre = "a" * 51
    assert_not @usuario.valid?
  end

  test "email no debe ser muy largo" do
    @usuario.email = "a" * 244 + "@example.com"
    assert_not @usuario.valid?
  end
  
  test "email validacion debe acceptar direcciones validas" do
    valid_addresses = %w[usuario@example.com USUARIOS@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @usuario.email = valid_address
      assert @usuario.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[usuario@example,com usuario_at_foo.org usuario.name@example. foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @usuario.email = invalid_address
      assert_not @usuario.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test "direccion de email debe ser unica" do
    duplicate_usuario = @usuario.dup
    duplicate_usuario.email = @usuario.email.upcase
    @usuario.save
    assert_not duplicate_usuario.valid?
  end
  
  test "password debe existir (nonblank)" do
    @usuario.password = @usuario.password_confirmation = " " * 6
    assert_not @usuario.valid?
  end

  test "correos electronicos deben ser guardados en minusculas" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @usuario.email = mixed_case_email
    @usuario.save
    assert_equal mixed_case_email.downcase, @usuario.reload.email
  end
  
  test "password debe tener un tamaño minimo" do
    @usuario.password = @usuario.password_confirmation = "a" * 5
    assert_not @usuario.valid?
  end
  
  test "authenticated? should return false for a usuario with nil digest" do
    assert_not @usuario.authenticated?('')
  end
  
end
