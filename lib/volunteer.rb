class Volunteer

  attr_reader :name, :id, :project_id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @project_id = attributes.fetch(:project_id)
    @id = attributes.fetch(:id)
  end

  def save
    result = DB.exec("
      INSERT INTO volunteers (name, project_id)
      VALUES ('#{@name}',#{@project_id}) RETURNING id;
    ")
    @id = result.first.fetch('id').to_i
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
      volunteers.push(Volunteer.new({
        :name => name,
        :project_id => project_id,
        :id => id
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

end
