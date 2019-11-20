require 'test_helper'

class RubocopTest < ActiveSupport::TestCase
  test 'everything formatted according to rubocop' do
    assert_match(/no\ offenses\ detected/, `rubocop`)
  end
end
