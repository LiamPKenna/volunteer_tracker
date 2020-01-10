require "volunteer"
require "project"
require "rspec"
require "pry"
require "pg"

# FOR WINDOWS
require "./config"
DB = PG.connect(TEST_DB_PARAMS)

# FOR MAC/LINUX
# DB = PG.connect({:dbname => 'volunteer_tracker_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec('DELETE FROM volunteers *;')
    DB.exec('DELETE FROM projects *;')
  end
end
