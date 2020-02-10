require 'application_system_test_case'

class TaskTest < ApplicationSystemTestCase
  setup do
    @customer = customers(:heidi)
  end

  test 'creates event in calendar' do
    visit customer_path(@customer, 'current-date': '2020-01-01T08:00')
    find('.fc-slats tbody > tr:nth-child(17) > td:nth-child(2)').click
    assert_equal '2020-01-02T08:00', find_field('Zeitpunk').value
    fill_in 'Titel', with: 'Hauswirtschaft'
    fill_in('Zeitpunkt', with: '020120201400')
    fill_in('Dauer', with: '0200')
    select('Wöchentlich', from: 'Wiederholen')
    click_button('Task erstellen')
    find('.fc-event .fc-time > span', text: '14:00 - 16:00')

    assert_equal all('.fc-event .fc-time > span').map(&:text), [
      '8:00 - 10:00',
      '12:00 - 14:00',
      '14:00 - 16:00',
    ]
  end
end
