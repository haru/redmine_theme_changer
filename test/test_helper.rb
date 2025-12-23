require 'simplecov'
require 'simplecov-rcov'
require 'simplecov-lcov'
# require 'coveralls'

SimpleCov::Formatter::LcovFormatter.config do |config|
  config.report_with_single_file = true
  config.single_report_path = File.expand_path(File.dirname(__FILE__) + '/../coverage/lcov.info')
end

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::RcovFormatter,
  SimpleCov::Formatter::LcovFormatter,
  SimpleCov::Formatter::HTMLFormatter
  # Coveralls::SimpleCov::Formatter
]

SimpleCov.start do
  root File.expand_path(File.dirname(__FILE__) + '/..')
  add_filter "/test/"
end

require File.expand_path(File.dirname(__FILE__) + '/../../../test/test_helper')

# Configure fixture path for plugin
ActiveSupport::TestCase.fixture_paths << File.expand_path('../fixtures', __FILE__)
