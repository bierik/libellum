require 'test_helper'

def assert_create_task(frequency, expected)
  assert_difference('Task.count') do
    travel_to Time.zone.parse('2020-02-04') do
      post customer_tasks_url(@customer, format: :json), params: { task: {
        duration: '02:00',
        title: 'Putzen',
        datetime: Time.zone.parse('2020-02-04'),
        frequency: frequency,
      } }
    end
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
      %w[Fahrstunde Verkehrskundeunterricht],
      response.parsed_body.map { |task| task['title'] },
    )
  end

  test 'should create single task' do
    assert_create_task('',
                       'title' => 'Putzen',
                       'rrule' => "DTSTART;TZID=Europe/Zurich:20200204T000000\nCOUNT=1",
                       'duration' => '02:00',)
  end

  test 'should create fort nightly task' do
    assert_create_task('FORT_NIGHTLY',
                       'title' => 'Putzen',
                       'rrule' => "DTSTART;TZID=Europe/Zurich:20200204T000000\nFREQ=WEEKLY;INTERVAL=2",
                       'duration' => '02:00',)
  end

  test 'should create weekly task' do
    assert_create_task('WEEKLY',
                       'title' => 'Putzen',
                       'rrule' => "DTSTART;TZID=Europe/Zurich:20200204T000000\nFREQ=WEEKLY",
                       'duration' => '02:00',)
  end

  test 'should create monthly task' do
    assert_create_task('MONTHLY',
                       'title' => 'Putzen',
                       'rrule' => "DTSTART;TZID=Europe/Zurich:20200204T000000\nFREQ=MONTHLY",
                       'duration' => '02:00',)
  end

  test 'should throw an error for unsupported frequency' do
    post customer_tasks_url(@customer, format: :json), params: { task: {
      duration: '02:00',
      title: 'Putzen',
      datetime: Time.zone.parse('2020-02-04'),
      frequency: 'UNSUPPORTED',
    } }
    assert_response :bad_request
    assert_equal({
                   'message' => 'Only , DAILY, WEEKLY, FORT_NIGHTLY, MONTHLY are allowed frequencies',
                 }, response.parsed_body,)
  end

  test 'should destroy task' do
    assert_difference('Task.count', -1) do
      delete customer_task_url(@customer, @single_task)
    end
  end
end
