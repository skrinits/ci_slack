require 'spec_helper'

RSpec.describe CiSlack::Configuration do
  it 'default params' do
    config = CiSlack::Configuration.new

    expect(config.failed_icon).to eq('failed')
    expect(config.failed_title).to eq('CI FAILED!')
    expect(config.success_icon).to eq('successful')
    expect(config.success_title).to eq('SUCCESS')
    expect(config.channel).to eq('#ci')
    expect(config.ci_computer).to eq('CI')
    expect(config.project).to eq('')
    expect(config.slack_names).to eq({})
    expect(config.skip_success_message).to eq([])
  end
end
