require_relative 'patch'
require_relative '../messager'

module CiSlack
  module Rspec
    class Notifier
      attr_reader :messager

      def initialize
        @messager = CiSlack::Messager.new
      end

      def example_failed(notification)
        messager.deliver(Example.new(notification.example).to_s, :failed)
      end

      class Example
        def initialize(example)
          @example = example
        end

        def to_s
          %(\n*Failed test:*
            > Scenario: _#{ description }_
            > File: #{ error_location }
            > Error: ```#{ error }```\n)
        end

        private

        def description
          @example.metadata[:full_description]
        end

        def error
          @example.execution_result.exception.to_s
        end

        def error_location
          @example.metadata[:location]
        end
      end
    end
  end
end

RSpec.configure do |config|
  config.fail_fast = !ENV[CiSlack.configuration.ci_computer].nil?
  config.reporter.register_listener CiSlack::Rspec::Notifier.new, :example_failed
end
