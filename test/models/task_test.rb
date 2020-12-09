require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  test 'Calculates rrule' do
    task = Task.new(frequency: :weekly, datetime: Time.zone.parse('2020-01-01 08:00'))
    assert_equal ({
      dtstart: '20200101T080000',
      tzid: 'Europe/Zurich',
      freq: 'WEEKLY',
    }), task.rrule

    task = Task.new(frequency: :daily, datetime: Time.zone.parse('2020-01-01 12:00'))
    assert_equal ({
      dtstart: '20200101T120000',
      tzid: 'Europe/Zurich',
      freq: 'DAILY',
    }), task.rrule

    task = Task.new(frequency: :fort_nightly, datetime: Time.zone.parse('2020-01-01 08:00'))
    assert_equal ({
      dtstart: '20200101T080000',
      tzid: 'Europe/Zurich',
      freq: 'WEEKLY',
      interval: 2,
    }), task.rrule
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
