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

get('/projects/:id') do
  @project = Project.find(params[:id].to_i)
  erb(:project)
end

get('/projects/:id/edit') do
  @project = Project.find(params[:id].to_i)
  erb(:edit_project)
end

patch('/projects/:id') do
  @project = Project.find(params[:id].to_i)
  @project.update({:title => params[:title]})
  redirect to("/projects/#{params[:id]}")
end

delete('/projects/:id') do
  @project = Project.find(params[:id].to_i)
  @project.delete
  redirect to('/projects')
end

get('/projects/:id/volunteers/:volunteer_id') do
  @volunteer = Volunteer.find(params[:volunteer_id].to_i)
  erb(:volunteer)
end

patch('/projects/:id/volunteers/:volunteer_id') do
  @volunteer = Volunteer.find(params[:volunteer_id].to_i)
  erb(:volunteer)
  @volunteer.update({:name => params[:name]})
  redirect to("/projects/#{params[:id]}/volunteers/#{params[:volunteer_id]}")
end

patch('/projects/:id/volunteers/:volunteer_id/hours') do
  @volunteer = Volunteer.find(params[:volunteer_id].to_i)
  erb(:volunteer)
  @volunteer.add_hours(params[:hours].to_i)
  redirect to("/projects/#{params[:id]}/volunteers/#{params[:volunteer_id]}")
end

post('/projects/:id/volunteers') do
  name = params[:name]
  new_volunteer = Volunteer.new({:name => name, :id => nil, :project_id => params[:id].to_i, :hours => 0})
  new_volunteer.save
  redirect to("/projects/#{params[:id]}")
end

delete('/projects/:id/volunteers/:volunteer_id') do
  @volunteer = Volunteer.find(params[:volunteer_id].to_i)
  @volunteer.delete
  redirect to("/projects/#{params[:id]}")
end
