module CiSlack
  class Configuration
    attr_accessor :webhook, :channel, :ci_computer,
                  :bot_name, :project, :slack_names,
                  :failed_icon, :success_icon,
                  :failed_title, :success_title

    def initialize
      @webhook = ''
      @channel = '#ci'
      @bot_name = 'CI BOT'
      @project = ''
      @slack_names = {}
      @ci_computer = 'CI'

      @failed_icon = 'failed'
      @success_icon = 'successful'
      @failed_title = 'CI FAILED!'
      @success_title = 'SUCCESS'
    end
  end
end
