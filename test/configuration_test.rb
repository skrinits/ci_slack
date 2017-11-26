require 'test_helper'

class ConfigurationTest < ActiveSupport::TestCase
  test 'default params' do
    config = CiSlack::Configuration.new

    assert_equal('failed', config.icon)
    assert_equal('', config.webhook)
    assert_equal('#ci', config.channel)
    assert_equal('CI', config.ci_computer)
    assert_equal('CI BOT', config.bot_name)
    assert_equal('', config.project)
    assert_equal({}, config.slack_names)
  end
end
