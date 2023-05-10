require_relative 'peep'

class PeepRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, content, time, user_id FROM peeps;
    query = 'SELECT id, content, time, user_id FROM peeps;'

    result = DatabaseConnection.exec_params(query, [])
    # Returns an array of Peep objects.
    peeps = []

    result.each do |record|
      peep = Peep.new

      peep.id = record['id']
      peep.content = record['content']
      peep.time = record['time']
      peep.user_id = record['user_id']

      peeps << peep
    end

    return peeps
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, content, time, user_id FROM peeps WHERE id = $1;
    query = 'SELECT id, content, time, user_id FROM peeps WHERE id = $1;'

    result = DatabaseConnection.exec_params(query, [id])
    # Returns a single Peep object.
    record = result[0]
    
    peep = Peep.new

    peep.id = record['id']
    peep.content = record['content']
    peep.time = record['time']
    peep.user_id = record['user_id']

    return peep
  end

  # creates a new record on the database
  # one argument: a Peep instance
  def create(peep)
    # Executes the SQL query:
    # INSERT INTO peeps (content, time, user_id) VALUES ($1, $2, $3);
    query = 'INSERT INTO peeps (content, time, user_id) VALUES ($1, $2, $3);'

    params = [peep.content, peep.time, peep.user_id]

    DatabaseConnection.exec_params(query, params)
    # Returns nothing
  end

  # def update(peep)
  # end

  # def delete(peep)
  # end
end
