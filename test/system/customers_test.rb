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

  test 'create a customer' do
    visit new_customer_path
    click_on 'Kunde erstellen'

    assert_equal 'muss ausgefüllt werden', all('.invalid-feedback').first.text

    fill_in 'Vorname', with: 'Hans'
    fill_in 'Nachname', with: 'Meier'
    fill_in 'Strasse', with: 'Kleeweg'
    fill_in 'Nummer', with: '12'
    fill_in 'PLZ', with: '8888'
    fill_in 'Ort', with: 'Baden'

    click_on 'Kunde erstellen'

    assert_equal "Kunde wurde erfolgreich erstellt.\n×", find('.alert').text
  end
end
