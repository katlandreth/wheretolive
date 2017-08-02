require 'test_helper'
require 'generators/scraper_template/scraper_template_generator'

class ScraperTemplateGeneratorTest < Rails::Generators::TestCase
  tests ScraperTemplateGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
