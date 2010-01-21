namespace :db do
  namespace :seed do
    require 'db/seed_tables'
 
    desc "dump the tables holding seed data to db/RAILS_ENV_seed.sql. SEED_TABLES need to be defined in config/environment.rb!!!"
    task :dump => :environment do
      config = ActiveRecord::Base.configurations[RAILS_ENV]
      # -f flag is for 'force' and -t flag is for 'no table info, only data'
      dump_cmd = "mysqldump -f -t --user=#{config['username']} --password=#{config['password']} #{config['database']} #{SEED_TABLES.join(" ")} > db/#{RAILS_ENV}_seed.sql"
      system(dump_cmd)
    end
 
    desc "load the dumped seed data from db/development_seed.sql into the test database"
    task :load => :environment do
      config = ActiveRecord::Base.configurations['test']
      system("mysql --user=#{config['username']} --password=#{config['password']} #{config['database']} < db/#{RAILS_ENV}_seed.sql")
     end
  end
end
