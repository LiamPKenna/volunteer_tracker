class Volunteer

  attr_reader :name, :id, :project_id, :hours

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @project_id = attributes.fetch(:project_id)
    @id = attributes.fetch(:id)
    @hours = attributes.fetch(:hours)
  end

  def save
    result = DB.exec("
      INSERT INTO volunteers (name, project_id)
      VALUES ('#{@name}',#{@project_id}) RETURNING id;
    ")
    @id = result.first.fetch('id').to_i
  end

  def update(attributes)
    @name = attributes.fetch(:name)
    DB.exec("UPDATE volunteers SET name = '#{@name}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM volunteers WHERE id = #{@id};")
  end

  def ==(volunteer_to_compare)
    self.name == volunteer_to_compare.name
  end

  def self.get_volunteers(db_query)
    returned_volunteers = DB.exec(db_query)
    volunteers = []
    returned_volunteers.each() do |volunteer|
      name = volunteer.fetch('name')
      project_id = volunteer.fetch('project_id').to_i
      id = volunteer.fetch('id').to_i
      hours = volunteer.fetch('hours').to_i
      volunteers.push(Volunteer.new({
        :name => name,
        :project_id => project_id,
        :id => id,
        :hours => hours
      }))
    end
    volunteers
  end

  def self.all
    self.get_volunteers('SELECT * FROM volunteers;')
  end

  def self.find(id)
    self.get_volunteers("SELECT * FROM volunteers WHERE id = #{id};").first
  end

  def self.find_by_project(project_id)
    self.get_volunteers("SELECT * FROM volunteers WHERE project_id = #{project_id};")
  end

  def add_hours(hours)
    @hours += hours.to_i
    DB.exec("UPDATE volunteers SET hours = '#{@hours}' WHERE id = #{@id};")
  end
end
