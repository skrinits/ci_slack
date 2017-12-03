require 'slack-notifier'
require 'ci_slack'

module CiSlack
  class Messager
    # status: failed or success
    def deliver(message = nil, status = :success)
      return unless ENV[ci_computer.to_s]

      author, commit_message = last_git_log

      client.post(text: text(status, author, commit_message, message),
                  icon_emoji: ":#{ send(status.to_s + '_icon') }:")
    end

    def method_missing(method, *args)
      if %i[success_icon failed_icon skip_success_message
            failed_title success_title webhook channel
            ci_computer bot_name project slack_names].include?(method)
        CiSlack.configuration.send(method)
      else
        super
      end
    end

    private

    def text(status, author, commit_message, message)
      "#{ project }. #{ send(status.to_s + '_title') }\n#{ slack_name(author, status) } : #{ commit_message }\n#{ message }"
    end

    def slack_name(author, status)
      slack_name = slack_names.select { |key, _| author.downcase =~ key }.values.first

      unless slack_name.nil?
        if skip_success_message.include?(slack_name) && status == :success 
          slack_name
        else
          "<@#{ slack_name }>"
        end
      else
        author
      end
    end

    def last_git_log
      `git log -1 --pretty='%an||%s'`.split('||').map(&:strip)
    end

    def client
      @client ||= ::Slack::Notifier.new(webhook, channel: channel, username: bot_name)
    end
  end
end
