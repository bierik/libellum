require 'application_system_test_case'

class FlatTemplatesTest < ApplicationSystemTestCase
  setup do
    @flat_template = flat_templates(:putzstein)
  end

  test 'visiting the index' do
    visit flat_templates_url
    assert_selector 'h1', text: 'Flat Templates'
  end
end
