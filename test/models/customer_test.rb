require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  setup do
    @customer = customers(:heidi)
  end

  test 'should calculate distance' do
    @customer.calculate_route_flat!
    assert_equal 3000, @customer.distance
    assert_equal 5, @customer.route_flat
  end
end
