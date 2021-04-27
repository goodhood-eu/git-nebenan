module Git
  module Nebenan
    module Commands
      class Config < Command
        def initialize(options)
          @options = options
        end

        def execute
          config.set('jira.username', value: prompt.ask('JIRA username', default: ENV['USER']))
          config.set('jira.password', value: prompt.mask('JIRA password'))
          config.set('jira.site', value: prompt.ask('JIRA site', default: 'https://jira.nebenan.de/'))
          config.set('jira.project', value: prompt.ask('JIRA project', default: 'CORE'))
          config.write(force: true)
        end
      end
    end
  end
end
