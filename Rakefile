require 'active_record'
require 'yaml'
require 'logger'

namespace :db do
  task :load_config do
    dbconfig = YAML.load(File.read('config/database.yml'))
    ActiveRecord::Base.establish_connection dbconfig['db']
    ActiveRecord::Base.logger = Logger.new('db/database.log')
  end

  task migrate: :load_config do
    ActiveRecord::Migrator.migrate('db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil )
  end
end
