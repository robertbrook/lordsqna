
namespace :lordsqna do

  task :migrate_down => :environment do
    ENV['VERSION'] = '0'
    puts 'About to migrate down to VERSION=0'
    Rake::Task['db:migrate'].execute('param needed for rake')
    puts 'Migrated down to VERSION=0'
  end

  task :migrate_up => :environment do
    ENV.delete('VERSION')
    puts 'Abou to migrate up to latest VERSION'
    Rake::Task['db:migrate'].execute('param needed for rake')
    puts 'Migrated up to latest VERSION'
  end

  task :clone_structure do
    puts 'About to clone structure to test database'
    Rake::Task['db:test:clone'].invoke
    puts 'Cloned structure to test database'
  end

  desc 'migrates db down and up, does db:test:clone_structure, and runs rake spec'
  task :clean => [:migrate_down, :migrate_up, :clone_structure] do
  end

  task :load_answers do
    Dir["#{RAILS_ROOT}/data/*"].each do |file|
      puts 'todo: load '+file
    end
  end

  desc 'does a clean sweep and loads xml, reindexes with solr'
  task :regenerate => [:migrate_down, :migrate_up, :load_answers] do
    puts 'Regenerated all data'
  end

end

desc "Migrate down and up, load data, clone db structure"
task :lordsqna => "lordsqna:regenerate"
