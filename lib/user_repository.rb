require_relative 'user'

class UserRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, username, email, password FROM users;

    # Returns an array of User objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, username, email, password FROM users WHERE id = $1;

    # Returns a single User object.
  end

  # creates a new record on the database
  def create(user)
    # Executes the SQL query:
    # INSERT INTO users (name, username, email, password) VALUES $1, $2, $3, $4;

    # Returns nothing
  end

  # def update(user)
  # end

  # def delete(user)
  # end
end