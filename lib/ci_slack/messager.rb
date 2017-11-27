require 'slack-notifier'
require 'ci_slack'

module CiSlack
  class Messager
    def send(message)
      return unless ENV[ci_computer.to_s]

      author, commit_message = last_git_log
      slack_name = slack_names.select { |key, _| author.downcase =~ key }.values.first || author

      text = "#{ project }. CI FAILED!\n<@#{ slack_name }> : #{ commit_message } \n#{ message }"

      client.post(text: text, icon_emoji: ":#{ icon }:")
    end

    def method_missing(method, *args)
      if %i[icon webhook channel ci_computer
            bot_name project slack_names].include?(method)
        CiSlack.configuration.send(method)
      else
        super
      end
    end

    private

    def last_git_log
      `git log -1 --pretty='%an||%s'`.split('||').map(&:strip)
    end

    def client
      @client ||= ::Slack::Notifier.new(webhook, channel: channel, username: bot_name)
    end
  end
end
