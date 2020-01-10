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
  redirect to('/projects')
end

get('/projects') do
  @projects = Project.all
  erb(:projects)
end

post('/projects') do
  title = params[:title]
  new_project = Project.new({:title => title, :id => nil})
  new_project.save
  redirect to('/projects')
end

patch('/') do
end

delete('/') do
end
