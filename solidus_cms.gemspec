# frozen_string_literal: true

require_relative 'lib/solidus_cms/version'

Gem::Specification.new do |spec|
  spec.name = 'solidus_cms'
  spec.version = SolidusCms::VERSION
  spec.authors = ['MagmaLabs']
  spec.email = 'developers@magmalabs.com'

  spec.summary = 'Solidus extension to allow content management.'
  spec.description = 'Allow content management system in your solidus store.'
  spec.homepage = 'https://github.com/solidusio-contrib/solidus_cms#readme'
  spec.license = 'BSD-3-Clause'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/magma-labs/solidus_cms'

  spec.required_ruby_version = Gem::Requirement.new('> 2.5')

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  files = Dir.chdir(__dir__) { `git ls-files -z`.split("\x0") }

  spec.files = files.grep_v(%r{^(test|spec|features)/})
  spec.test_files = files.grep(%r{^(test|spec|features)/})
  spec.bindir = "exe"
  spec.executables = files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'bootstrap_form'
  spec.add_dependency 'haml'
  spec.add_dependency 'solidus_backend', ['>= 2.0.0', '< 4']
  spec.add_dependency 'solidus_core', ['>= 2.0.0', '< 4']
  spec.add_dependency 'solidus_support', '~> 0.5'

  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'solidus_dev_support', '~> 2.5'
end
