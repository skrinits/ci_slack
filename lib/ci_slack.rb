require 'ci_slack/configuration'

module CiSlack
  class << self  
    def configuration
      @configuration ||= CiSlack::Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end
