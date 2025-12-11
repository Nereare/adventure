# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = 'adventure'
  spec.version       = '0.1.0'
  spec.author        = 'Igor Padoim'
  spec.email         = 'igorpadoim@gmail.com'
  spec.license       = 'WTFPL'

  spec.summary       = 'This is a theme for Jekyll intended to be used as a template for interactive RPG solo adventures.'
  spec.homepage      = 'https://github.com/Nereare/adventure'

  spec.metadata['source_code_uri']   = spec.homepage
  spec.metadata['changelog_uri']     = 'https://github.com/Nereare/adventure/blob/master/CHANGELOG.md'
  spec.metadata['documentation_uri'] = 'https://nereare.github.io/adventure'
  spec.metadata['bug_tracker_uri']   = 'https://github.com/Nereare/adventure/issues'
  spec.metadata['github_repo']       = 'https://github.com/Nereare/adventure.git'

  spec.files = `git ls-files -z`.split("\x0").select do |f|
    f.match(%r{^(((_includes|_layouts|_sass|_plugins|assets|assets\/css)\/)+[0-9a-z\-\_]+\.[a-z]+)|((404|CHANGELOG|LICENSE|CODE-OF-CONDUCT|CONTRIBUTING|README|[a-z]+_collection|search)\.[a-z]+)$}i)
  end

  spec.required_ruby_version = '~> 3.2'

  spec.add_development_dependency 'html-proofer', '~> 5.1'
  spec.add_development_dependency 'nokogiri', '~> 1.18'
  spec.add_development_dependency 'webrick', '~> 1.9'

  spec.add_dependency 'jekyll', '~> 4.4'
  spec.add_dependency 'jekyll-feed', '~> 0.17'
  spec.add_dependency 'jekyll-redirect-from', '~> 0.16'
  spec.add_dependency 'jekyll-seo-tag', '~> 2.8'
  spec.add_dependency 'jekyll-sitemap', '~> 1.4'
  spec.add_dependency 'jemoji', '~> 0.13'
end
