module Git
  module Nebenan
    module Commands
      class Command
        def config
          @config ||= begin
            config = TTY::Config.new
            config.filename = ".git-nebenan"
            config.extname = ".toml"
            config.append_path Dir.home
            config.read if config.exist?
            config
          end
        end

        def prompt
          @prompt ||= TTY::Prompt.new(help_color: :cyan)
        end

        def jira_client
          @jira_client ||= JIRA::Client.new(
            username:      config.fetch('jira.username'),
            password:      config.fetch('jira.password'),
            site:          config.fetch('jira.site'),
            context_path:  '',
            auth_type:     :basic,
          )
        end

        def logger
          @logger ||= TTY::Logger.new do |log|
            log.types = {
              remote:  { level: :info },
              local:   { level: :info },
              create:  { level: :info },
              command: { level: :info },
            }
            log.handlers = [
              [
                :console,
                {
                  styles: {
                    remote: { symbol: "✔", label: "remote", color: :yellow, levelpad: 0 },
                    local: { symbol: "✔", label: "local", color: :green, levelpad: 0 },
                    create: { symbol: "+", label: "create", color: :blue, levelpad: 0 },
                    command: { symbol: " ", label: "   ", color: :dim, levelpad: 0 },
                  }
                }
              ]
            ]
          end
        end

        def platform
          @platform ||= TTY::Platform.new
        end
      end
    end
  end
end
