# CiSlack

This gem provide sending message about a failed step of continiues integration.

## Getting Started

in config/initializes/ci_slack.rb

```ruby
CiSlack.configure do |config|
  config.webhook = 'ci webhook'
  config.project = 'your project'
  config.slack_names = { mapping to slack names }
  config.failed_icon = 'slack icon (default "failed")'
  config.success_icon = 'slack icon (default "successful")'
  config.failed_title = 'slack icon (default "CI FAILED!")'
  config.success_title = 'slack icon (default "SUCCESS")'
  config.channel = 'slack channel (default "ci")'
  config.ci_computer = 'check name for ci computer (default "CI")'
  config.bot_name = 'name for sender to slack (default "CI BOT")'
end
```

example:

```ruby
CiSlack.configure do |config|
  config.webhook = 'https://hooks.slack.com/services/XXXXXXXXX'
  config.project = 'your project'
  config.slack_names = { %r{криницын|skrinits} => 'skrinits' }
  config.icon = 'failed'
  config.channel = '#ci'
  config.ci_computer = 'CI'
  config.bot_name = 'CI BOT'
end
```

### Rspec

in spec_helper.rb:

```ruby
require 'ci_slack/rspec/notifier'
```

### In code executed in a CI step:

```ruby
require_relative '../../config/initializers/ci_slack'
require 'ci_slack/messager'

CiSlack::Messager.new.deliver(message_to_slack_channel, :failed)
```

### In the task for a delivery information about success a pass of CI:
```ruby
task :success_ci do
  require_relative '../../config/initializers/ci_slack'
  require 'ci_slack/messager'

  CiSlack::Messager.new.deliver
end
```