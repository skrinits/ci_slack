require 'spec_helper'
require_relative '../lib/ci_slack/messager'

RSpec.describe CiSlack::Messager do
  before do
    CiSlack.configure do |config|
      %i[webhook channel ci_computer bot_name project slack_names success_title].each do |param|
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

  it "computer without ci: ENV['CI'] is absent" do
    ENV['ci_computer'] = nil

    messager = CiSlack::Messager.new

    expect(messager.deliver('message')).to be_nil
  end

  it "computer with ci: ENV['CI'] is present" do
    ENV['ci_computer'] = 'true'

    messager = CiSlack::Messager.new

    expect{messager.deliver('message')}.to raise_error(Slack::Notifier::APIError)
  end

  context 'configuration @skip_success_message' do
    let(:messager) { CiSlack::Messager.new }

    it 'present' do
      CiSlack.configure do |config|
        config.skip_success_message = ['author']
        config.slack_names = { %r{author} => 'author' }
      end

      expect(messager.send(:text, :success, 'author', 'commit_message', 'message')).
        to eq("project. success_title\nauthor : commit_message\nmessage")

    end

    it 'absent' do
      CiSlack.configure do |config|
        config.skip_success_message = []
        config.slack_names = { %r{author} => 'author' }
      end

      expect(messager.send(:text, :success, 'author', 'commit_message', 'message')).
        to eq("project. success_title\n<@author> : commit_message\nmessage")
    end
  end
end
