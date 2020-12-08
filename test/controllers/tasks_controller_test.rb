require 'test_helper'

def assert_create_task(frequency, expected)
  assert_difference('Task.count') do
    travel_to Time.zone.parse('2020-02-04') do
      post customer_tasks_url(@customer, format: :json), params: { task: {
        duration: '02:00',
        title: 'Fahren',
        datetime: Time.zone.parse('2020-02-04'),
        frequency: frequency,
      } }
    end
    assert_response :created
  end
  assert_equal(expected, response.parsed_body.slice('title', 'rrule', 'duration'))
end

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @single_task = tasks(:single)
    @organization = organizations(:fahrlehrer_peter)
    @customer = customers(:heidi)
  end

  test 'should get index' do
    get customer_tasks_url(@customer, format: :json)
    assert_response :success
    assert_equal(
      %w[Fahrstunde Fahrstunde Verkehrskundeunterricht],
      response.parsed_body.map { |task| task['title'] },
    )
  end

  test 'should create single task' do
    assert_create_task('never',
                       'title' => 'Fahren',
                       'rrule' => { 'dtstart' => '20200204T000000', 'tzid' => 'Europe/Zurich', 'count' => 1 },
                       'duration' => '02:00',)
  end

  test 'should create fort nightly task' do
    assert_create_task('fort_nightly',
                       'title' => 'Fahren',
                       'rrule' => {
                         'dtstart' => '20200204T000000',
                         'tzid' => 'Europe/Zurich',
                         'freq' => 'WEEKLY',
                         'interval' => 2,
                       },
                       'duration' => '02:00',)
  end

  test 'should create weekly task' do
    assert_create_task('weekly',
                       'title' => 'Fahren',
                       'rrule' => { 'dtstart' => '20200204T000000', 'tzid' => 'Europe/Zurich', 'freq' => 'WEEKLY' },
                       'duration' => '02:00',)
  end

  test 'should create monthly task' do
    assert_create_task('monthly',
                       'title' => 'Fahren',
                       'rrule' => { 'dtstart' => '20200204T000000', 'tzid' => 'Europe/Zurich', 'freq' => 'MONTHLY' },
                       'duration' => '02:00',)
  end

  test 'should destroy task' do
    assert_difference('Task.count', -1) do
      delete task_path(@single_task, format: :json)
    end
  end
end
