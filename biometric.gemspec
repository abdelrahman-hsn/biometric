# frozen_string_literal: true

require_relative 'lib/biometric/version'

Gem::Specification.new do |spec|
  spec.name = 'biometric'
  spec.version = Biometric::VERSION
  spec.authors = ['Abdelrahman Hassan']
  spec.email = ['abdelrahmanhsn1@gmail.com']

  spec.summary = 'Provides biometric authentication support for mobile devices'
  spec.description = 'A gem to work with mobile fingerprint or face biometric authentication'
  spec.homepage = 'https://github.com/abdelrahman-hsn/biometric'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.5.0'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/commits/main/"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.glob('{lib}/**/*', File::FNM_DOTMATCH)
                  .reject { |f| File.basename(f) == '.' || File.basename(f) == '..' }
                  .reject { |f| File.extname(f) == '.gem' }
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
