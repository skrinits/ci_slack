require 'spec_helper'

RSpec.describe CiSlack do
  it '.configure' do
    CiSlack.configure do |config|
      %i[failed_icon success_icon
         success_title failed_title
         webhook channel ci_computer
         bot_name project slack_names
         skip_success_message].each do |param|
        config.send("#{ param }=", param)
      end
    end

    %i[failed_icon success_icon
         success_title failed_title
         webhook channel ci_computer
         bot_name project slack_names
         skip_success_message].each do |param|
      expect(CiSlack.configuration.send(param)).to eq(param)
    end 
  end
end
