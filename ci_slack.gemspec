$:.push File.expand_path('../lib', __FILE__)

require 'ci_slack/version'

Gem::Specification.new do |s|
  s.name        = 'ci_slack'
  s.version     = CiSlack::VERSION
  s.authors     = ['skrinits']
  s.email       = ['slavakrinicyn@mail.ru']
  s.homepage    = 'https://github.com/skrinits/ci_slack'
  s.summary     = 'Slack report for Continiues Integration'
  s.description = 'Send a message on failure of Continiues Integration to the specific channel with a link to the author of a last commit'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'slack-notifier', '~> 2.3.1'
end
