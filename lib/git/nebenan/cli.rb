module Git
  module Nebenan
    class CLI < Thor
      Error = Class.new(StandardError)

      def self.exit_on_failure?
        true
      end

      register Git::Nebenan::Commands::Jira, 'jira', 'jira [SUBCOMMAND]', 'Interact with jira'

      desc 'version', 'app version'
      def version
        require_relative 'version'
        puts "v#{App::VERSION}"
      end
      map %w(--version -v) => :version
    end
  end
end
