require_relative 'peep'

class PeepRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, content, time, user_id FROM peeps;

    # Returns an array of Peep objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, content, time, user_id FROM peeps WHERE id = $1;

    # Returns a single Peep object.
  end

  # creates a new record on the database
  # one argument: a Peep instance
  def create(peep)
    # Executes the SQL query:
    # INSERT INTO peeps (content, time, user_id) VALUES ($1, $2, $3);

    # Returns nothing
  end

  # def update(peep)
  # end

  # def delete(peep)
  # end
end