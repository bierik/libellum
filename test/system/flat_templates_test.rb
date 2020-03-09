require 'application_system_test_case'

class FlatTemplatesTest < ApplicationSystemTestCase
  setup do
    @flat_template = flat_templates(:putzstein)
  end

  test 'visiting the index' do
    visit flat_templates_path
    assert_selector '.h2', text: 'Pauschalvorlagen'
  end
end
