# frozen_string_literal: true

require './lib/nocode/version'

Gem::Specification.new do |s|
  s.name        = 'nocode'
  s.version     = Nocode::VERSION
  s.summary     = 'Configurable low/no-code execution engine.'

  s.description = <<-DESCRIPTION
    Organize your Ruby code into small components.  Components can then be tied together and executed within a YAML file.
  DESCRIPTION

  s.authors     = ['Matthew Ruggio']
  s.email       = ['mattruggio@icloud.com']
  s.files       = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  s.bindir      = 'exe'
  s.executables = %w[nocode]
  s.license     = 'MIT'
  s.metadata    = {
    'bug_tracker_uri' => 'https://github.com/mattruggio/nocode/issues',
    'changelog_uri' => 'https://github.com/mattruggio/nocode/blob/main/CHANGELOG.md',
    'documentation_uri' => 'https://www.rubydoc.info/gems/nocode',
    'homepage_uri' => s.homepage,
    'source_code_uri' => s.homepage,
    'rubygems_mfa_required' => 'true'
  }

  s.required_ruby_version = '>= 2.6'

  s.add_development_dependency('guard-rspec')
  s.add_development_dependency('pry')
  s.add_development_dependency('rake')
  s.add_development_dependency('rspec')
  s.add_development_dependency('rubocop')
  s.add_development_dependency('rubocop-rake')
  s.add_development_dependency('rubocop-rspec')
  s.add_development_dependency('simplecov')
  s.add_development_dependency('simplecov-console')
end
