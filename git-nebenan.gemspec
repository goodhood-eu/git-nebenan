require_relative 'lib/git/nebenan/version'

Gem::Specification.new do |spec|
  spec.name          = "git-nebenan"
  spec.version       = Git::Nebenan::VERSION
  spec.authors       = ["Johannes Opper"]
  spec.email         = ["johannes.opper@nebenan.de"]

  spec.summary       = %q{Switch git branches based on JIRA issues.}
  spec.description   = %q{Switch git branches based on JIRA issues.}
  spec.homepage      = "https://www.nebenan.de"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/goodhood-eu/git-nebenan"
  spec.metadata["changelog_uri"] = "https://github.com/goodhood-eu/git-nebenan/CHANGELOG.md"

  spec.add_dependency 'jira-ruby'
  spec.add_dependency 'tty-prompt'
  spec.add_dependency 'tty-config'
  spec.add_dependency 'tty-platform'
  spec.add_dependency 'tty-logger'
  spec.add_dependency 'thor'
  spec.add_dependency 'toml'
  spec.add_development_dependency 'byebug'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.executables   = ["git-nebenan"]
  spec.require_paths = ["lib"]
end
