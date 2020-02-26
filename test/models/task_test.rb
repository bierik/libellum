require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  test 'Calculates rrule' do
    task = Task.new(frequency: :weekly, datetime: Time.zone.parse('2020-01-01 08:00'))
    assert_equal "DTSTART;TZID=Europe/Zurich:20200101T080000\nFREQ=WEEKLY", task.rrule

    task = Task.new(frequency: :daily, datetime: Time.zone.parse('2020-01-01 12:00'))
    assert_equal "DTSTART;TZID=Europe/Zurich:20200101T120000\nFREQ=DAILY", task.rrule

    task = Task.new(frequency: :fort_nightly, datetime: Time.zone.parse('2020-01-01 08:00'))
    assert_equal "DTSTART;TZID=Europe/Zurich:20200101T080000\nFREQ=WEEKLY;INTERVAL=2", task.rrule
  end

  test 'Provides list of human readable frequencies' do
    assert_equal [
      %w[Nie never],
      %w[Täglich daily],
      %w[Wöchentlich weekly],
      ['Alle zwei Wochen', 'fort_nightly'],
      %w[Monatlich monthly],
    ], Task.selectable_frequencies
  end
end
