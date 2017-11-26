require 'test_helper'
require_relative '../lib/ci_slack/messager'

class MessagerTest < ActiveSupport::TestCase
  setup do
    CiSlack.configure do |config|
      %i[icon webhook channel ci_computer bot_name project slack_names].each do |param|
        if param == :webhook
          config.send("#{ param }=", 'http://github.com')
        elsif param == :slack_names
          config.send("#{ param }=", {})
        else
          config.send("#{ param }=", param)
        end
      end
    end
  end

  test "computer without ci: ENV['CI'] is absent" do
    ENV['ci_computer'] = nil

    messager = CiSlack::Messager.new

    assert_nil(messager.send('message'))
  end

  test "computer with ci: ENV['CI'] is present" do
    ENV['ci_computer'] = 'true'

    messager = CiSlack::Messager.new

    assert_raise Slack::Notifier::APIError do
      messager.send('message')
    end
  end
end
