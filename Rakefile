#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

ContentPublishing::Application.load_tasks

desc 'run specs for app'
task :spec do
  RAILS_ENV='test'
  [:environment, 'db:drop', 'db:migrate'].each do |task|
    Rake::Task[task].invoke
  end
end

