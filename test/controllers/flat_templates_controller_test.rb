require 'test_helper'

class FlatTemplatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @flat_template = flat_templates(:putzstein)
  end

  test 'should get index' do
    get flat_templates_url
    assert_response :success
  end

  test 'should get new' do
    get new_flat_template_url
    assert_response :success
  end

  test 'should create flat_template' do
    assert_difference('FlatTemplate.count') do
      post flat_templates_url, params: { flat_template: { name: @flat_template.name, price: @flat_template.price } }
    end

    assert_redirected_to flat_template_url(FlatTemplate.last)
  end

  test 'should show flat_template' do
    get flat_template_url(@flat_template)
    assert_response :success
  end

  test 'should get edit' do
    get edit_flat_template_url(@flat_template)
    assert_response :success
  end

  test 'should update flat_template' do
    patch flat_template_url(@flat_template),
          params: { flat_template: { name: @flat_template.name, price: @flat_template.price } }
    assert_redirected_to flat_template_url(@flat_template)
  end

  test 'should destroy flat_template' do
    assert_difference('FlatTemplate.count', -1) do
      delete flat_template_url(@flat_template)
    end

    assert_redirected_to flat_templates_url
  end
end
