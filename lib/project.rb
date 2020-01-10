class Project

  attr_reader :title, :id

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end

  def save
        result = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;")
    @id = result.first.fetch('id').to_i
  end

  def ==(project_to_compare)
    self.title == project_to_compare.title
  end

  def self.get_projects(db_query)
    returned_projects = DB.exec(db_query)
    projects = []
    returned_projects.each() do |project|
      title = project.fetch('title')
      id = project.fetch('id').to_i
      projects.push(Project.new({:title => title, :id => id}))
    end
    projects
  end

  def self.all
    self.get_projects('SELECT * FROM projects;')
  end

  def self.find(id)
    self.get_projects("SELECT * FROM projects WHERE id = #{id};").first
  end

  def volunteers
    Volunteer.find_by_project(@id)
  end

  def update(attributes)
    @title = attributes.fetch(:title)
    DB.exec("UPDATE projects SET title = '#{@title}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM projects WHERE id = #{@id};")
  end
end
