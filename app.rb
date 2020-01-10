require('sinatra')
require('sinatra/reloader')
require('./lib/project')
require('./lib/volunteer')
require('pry')
require('pg')
also_reload('lib/**/*.rb')

# FOR WINDOWS
require('./config')
DB = PG.connect(DB_PARAMS)

# FOR MAC
# DB = PG.connect({:dbname => "volunteer_tracker"})

get('/') do
end

post('/') do
end

patch('/') do
end

delete('/') do
end
