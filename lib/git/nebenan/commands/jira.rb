module Git
  module Nebenan
    module Commands
      class Jira < Thor

        namespace :jira

        desc 'config', 'Command description...'
        def config(*)
          if options[:help]
            invoke :help, ['config']
          else
            Git::Nebenan::Commands::Config.new(options).execute
          end
        end

        desc 'checkout', 'Command description...'
        def checkout(*)
          if options[:help]
            invoke :help, ['checkout']
          else
            Git::Nebenan::Commands::Checkout.new(options).execute
          end
        end

        desc 'open', 'Open JIRA ticket in browser'
        def open(*)
          if options[:help]
            invoke :help, ['open']
          else
            Git::Nebenan::Commands::Open.new(options).execute
          end
        end
      end
    end
  end
end
