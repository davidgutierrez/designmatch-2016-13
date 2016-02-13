require 'test_helper'

class UsuarioTest < ActiveSupport::TestCase

  def setup
    @user = Usuario.new(nombre: "Usuario de Ejemplo", email: "usuario@ejemplo.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  test "debe ser valido" do
    assert @user.valid?
  end
  
  test "El nombre debe estar presente" do
    @user.nombre = "     "
    assert_not @user.valid?
  end

  test "El email debe estar presente" do
    @user.email = "     "
    assert_not @user.valid?
  end
  
  test "nombre no debe ser muy largo" do
    @user.nombre = "a" * 51
    assert_not @user.valid?
  end

  test "email no debe ser muy largo" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
  
  test "email validacion debe acceptar direcciones validas" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test "direccion de email debe ser unica" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "password debe existir (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "correos electronicos deben ser guardados en minusculas" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
  
  test "password debe tener un tamaño minimo" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end
