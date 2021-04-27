module Git
  module Nebenan
    module Commands
      class Open < Command
        def initialize(options)
          @options = options
        end

        def execute
          current_branch = `git branch --show-current`
          project        = config.fetch('jira.project')
          issue          = current_branch[/#{project}-\d+/]
          url            = [config.fetch('jira.site'), 'projects', project, 'issues', issue].join(?/).squeeze(?/)
          logger.info url

          if platform.mac?
            `open #{url}`
          elsif platform.linux?
            `xdg-open #{url}`
          else
            `start #{url}`
          end
        end
      end
    end
  end
end
