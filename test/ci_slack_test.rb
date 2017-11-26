require 'test_helper'

class CiSlackTest < ActiveSupport::TestCase
  test 'configure' do
    CiSlack.configure do |config|
      %i[icon webhook channel ci_computer bot_name project slack_names].each do |param|
        config.send("#{ param }=", param)
      end
    end

    %i[icon webhook channel ci_computer bot_name project slack_names].each do |param|
      assert_equal(CiSlack.configuration.send(param), param)
    end
  end
end
