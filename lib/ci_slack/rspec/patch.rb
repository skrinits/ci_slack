# added a check on present @profiler
module RSpec::Core
  class Reporter
    def finish
      close_after do
        stop
        notify :start_dump,    Notifications::NullNotification
        notify :dump_pending,  Notifications::ExamplesNotification.new(self)
        notify :dump_failures, Notifications::ExamplesNotification.new(self)
        notify :deprecation_summary, Notifications::NullNotification
        unless mute_profile_output?
          notify :dump_profile, Notifications::ProfileNotification.new(@duration, @examples,
                                                                       @configuration.profile_examples,
                                                                       @profiler&.example_groups)
        end
        notify :dump_summary, Notifications::SummaryNotification.new(@duration, @examples, @failed_examples,
                                                                     @pending_examples, @load_time)
        notify :seed, Notifications::SeedNotification.new(@configuration.seed, seed_used?)
      end
    end
  end
end
