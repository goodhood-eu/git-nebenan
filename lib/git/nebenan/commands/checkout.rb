module Git
  module Nebenan
    module Commands
      class Checkout < Command
        def initialize(options)
          @options = options
        end

        def execute
          unless config.exist?
            logger.error 'missing config'
            logger.info 'run `git nebenan jira config first`'
            return
          end

          issues = jira_client.Issue.jql("PROJECT = '#{config.fetch('jira.project')}' AND status in ('Backlog', 'To Do', 'In Progress')", fields: [:summary, :assignee])

          choices = issues.map { |issue| { name: present(issue), value: issue.key } }

          puts "\n"

          key = prompt.select("Choose ticket?", choices, filter: true)

          remote_branch = find_remote_branch(key)
          local_branch = find_local_branch(key)

          puts "\n"

          command = if !local_branch.empty?
                      logger.local "branch found, switching:"
                      # puts Pastel.new.dim("  git checkout #{local_branch}")
                      # `git checkout #{local_branch}`
                      "git checkout #{local_branch}"
                    elsif !remote_branch.empty?
                      logger.remote "branch found, checking out:"
                      "git checkout -t #{remote_branch}"
                    else
                      logger.create "missing branch:"
                      "git checkout -b feature/#{generate_branch_name(issues.find { |i| i.key == key })}"
                    end

          puts Pastel.new.dim("  #{command}")
          puts "\n"
          `#{command}`
        rescue TTY::Reader::InputInterrupt
          puts "\n"
          logger.error 'aborted'
        end

        def find_remote_branch(key)
          `git branch --remote --list '**/#{key}*' --format \"%(refname:short)\"`.strip
        end

        def find_local_branch(key)
          `git branch --list '**/#{key}*' --format \"%(refname:short)\"`.strip
        end

        def generate_branch_name(issue)
          [issue.key, issue.fields['summary'].strip.squish.downcase].join(' ').gsub(/\W/, ?-)
        end

        def present(issue)
          "#{issue.key} #{issue.fields['summary']} (#{issue.fields.dig('assignee', 'key') || Pastel.new.red('unassigned')})"
        end
      end
    end
  end
end
