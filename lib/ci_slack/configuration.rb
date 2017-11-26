class CiSlack::Configuration
  attr_accessor :icon, :webhook, :channel, :ci_computer,
                :bot_name, :project, :slack_names

  def initialize
    @icon = 'failed'
    @webhook = ''
    @channel = '#ci'
    @bot_name = 'CI BOT'
    @project = ''
    @slack_names = {}
    @ci_computer = 'CI'
  end
end
