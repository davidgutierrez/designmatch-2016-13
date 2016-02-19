require 'test_helper'

class ProyectsDesignTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @proyect = proyects(:orange)
  end

  test "design display" do
    get proyect_path(@proyect)
    assert_template 'proyects/show'
    assert_select 'title', full_title(@proyect.name)
    assert_select 'h1', text: @proyect.name
    assert_match @proyect.designs.count.to_s, response.body
    assert_select 'div.pagination'
    @proyect.designs.paginate(page: 1).each do |design|
#      assert_match design.email, response.body
    end
  end
end