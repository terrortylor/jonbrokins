require "bundler/gem_tasks"
require "rspec/core/rake_task"

namespace :gem do
  desc 'Build the jonbrokins gem'
  task :build do
    system 'gem build jonbrokins.gemspec'
  end

  desc 'Install the gem locally'
  task :install do
    system 'gem install jonbrokins --no-doc'
  end
end

RSpec::Core::RakeTask.new(:spec)

task :default => :spec
