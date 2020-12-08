require 'application_system_test_case'

class TaskTest < ApplicationSystemTestCase
  setup do
    @customer = customers(:heidi)
  end

  test 'creates event in calendar' do
    visit customer_path(@customer, 'current-date': '2020-01-01T08:00')
    find('[data-time="08:00:00"]:nth-child(2)').click

    assert_equal '02.01.2020 08:00', find_field('Zeitpunkt').value
    assert_equal '00:15', find_field('Dauer').value

    fill_in 'Titel', with: 'Hauswirtschaft'
    fill_in 'Zeitpunkt', with: '02.01.2020 14:00'
    fill_in 'Dauer', with: '02:00'
    select 'Wöchentlich', from: 'Wiederkehrend'
    click_on('Auftrag erstellen')
    find('.fc-event-time', text: '14:00 - 16:00')

    assert_equal [
      '8:00 - 10:00',
      '8:00 - 10:00',
      '12:00 - 14:00',
      '12:00 - 14:00',
      '14:00 - 16:00',
      '12:00 - 14:00',
      '12:00 - 14:00',
      '12:00 - 14:00',
    ], all('.fc-event-time').map(&:text)
  end

  test 'creates event in calendar in month view' do
    visit customer_path(@customer, 'current-date': '2020-01-01T08:00')
    click_on('Monat')
    find('[data-date="2020-01-02"] .fc-daygrid-day-top').click

    assert_equal '02.01.2020 08:00', find_field('Zeitpunkt').value
    assert_equal '01:00', find_field('Dauer').value

    fill_in 'Titel', with: 'Hauswirtschaft'
    click_on('Auftrag erstellen')
    find('.fc-event-time', text: '08 Uhr - 09 Uhr')
  end
end
