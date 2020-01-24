require 'application_system_test_case'

class CustomersTest < ApplicationSystemTestCase
  setup do
    @customer = customers(:heidi)
  end

  test 'updates route flat' do
    visit edit_customer_path(@customer)
    assert_equal '', find_field('Wegpauschale').value
    click_on 'berechnen'
    assert_equal '5', find_field('Wegpauschale').value
    fill_in 'Wegpauschale', with: '20'
    click_on 'Kunde aktualisieren'
    assert_equal '20', find_field('Wegpauschale').value
    click_on 'berechnen'
    assert_equal '5', find_field('Wegpauschale').value
  end
end
