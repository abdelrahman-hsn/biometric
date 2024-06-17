# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

require 'rubocop/rake_task'

RuboCop::RakeTask.new

task default: %i[spec rubocop]

namespace :your_gem_name do
  desc "Copies the migration to the application's db/migrate directory"
  task install_migrations: :environment do
    ActiveRecord::Migrator.migrations_paths << File.expand_path('db/migrate', __dir__)
    ActiveRecord::MigrationContext.new(ActiveRecord::Migrator.migrations_paths).migrate
  end
end
