# frozen_string_literal: true

require_relative 'lib/adventure/meta'

Gem::Specification.new do |spec|
  spec.name        = Adventure::SLUG
  spec.version     = Adventure::VERSION
  spec.license     = Adventure::LICENSE
  spec.author      = Adventure::AUTHOR
  spec.email       = Adventure::AUTHOR_EMAIL
  spec.summary     = Adventure::DESCRIPTION
  spec.homepage    = 'https://github.com/Nereare/adventure'

  spec.required_ruby_version = '~> 3.2'

  spec.metadata['source_code_uri']       = spec.homepage
  spec.metadata['bug_tracker_uri']       = 'https://github.com/Nereare/adventure/issues'
  spec.metadata['changelog_uri']         = 'https://github.com/Nereare/adventure/blob/master/CHANGELOG.md'
  spec.metadata['documentation_uri']     = 'https://nereare.github.io/adventure/'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir[
    'lib/**/*.rb',
    'sig/*',
    'spec/*.rb',
    '.ruby-version',
    'CHANGELOG.md',
    'LICENSE.md',
    'Rakefile'
  ]
  spec.bindir        = 'bin'
  spec.executables   = 'adventure'
  spec.require_paths = %w[lib]

  spec.add_dependency 'tty-exit', '~> 0.1.0'
  spec.add_dependency 'tty-option', '~> 0.3.0'
  spec.add_dependency 'tty-prompt', '~> 0.23'

  spec.add_development_dependency 'rake', '~> 13.3'
  spec.add_development_dependency 'rdoc', '~> 6.15'
  spec.add_development_dependency 'rspec', '~> 3.13'
  spec.add_development_dependency 'rubocop', '~> 1.81', '>= 1.81.1'
  spec.add_development_dependency 'rubocop-rake', '~> 0.7.1'
  spec.add_development_dependency 'rubocop-rspec', '~> 3.7'
end
