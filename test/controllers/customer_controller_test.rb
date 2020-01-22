require 'test_helper'

class CustomerControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customer = customers(:heidi)
  end

  test 'should get index' do
    get customers_url
    assert_response :success
  end

  # test 'should get new' do
  #   get new_customer_url
  #   assert_response :success
  # end

  test 'should create customer' do
    assert_difference('Customer.count') do
      post customers_url, params: { customer: {
        first_name: @customer.first_name,
        last_name: @customer.last_name,
        street: @customer.street,
        number: @customer.number,
        place: @customer.place,
        zip: @customer.zip,
      } }
    end

    assert_redirected_to edit_customer_url(Customer.last)
  end

  test 'should show customer' do
    get customers_url(@customer)
    assert_response :success
  end

  test 'should get edit' do
    get edit_customer_url(@customer)
    assert_response :success
  end

  test 'should update customer' do
    patch customer_url(@customer),
          params: { customer: {
            first_name: @customer.first_name,
          } }
    assert_redirected_to edit_customer_url
  end

  test 'should destroy customer' do
    assert_difference('Customer.count', -1) do
      delete customer_url(@customer)
    end

    assert_redirected_to customers_url
  end
end
