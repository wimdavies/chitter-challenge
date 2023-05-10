require_relative 'user'

class UserRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, username, email, password FROM users;
    query = 'SELECT id, name, username, email, password FROM users;'

    result = DatabaseConnection.exec_params(query, [])
    # Returns an array of User objects.
    users = []
    
    result.each do |record|
      user = User.new

      user.id = record['id']
      user.name = record['name']
      user.username = record['username']
      user.email = record['email']
      user.password = record['password']

      users << user
    end

    return users
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, username, email, password FROM users WHERE id = $1;
    query = 'SELECT id, name, username, email, password FROM users WHERE id = $1;'

    result = DatabaseConnection.exec_params(query, [id])
    # Returns a single User object.
    record = result[0]

    user = User.new

    user.id = record['id']
    user.name = record['name']
    user.username = record['username']
    user.email = record['email']
    user.password = record['password']

    return user
  end

  # creates a new record on the database
  def create(user)
    # Executes the SQL query:
    # INSERT INTO users (name, username, email, password) VALUES ($1, $2, $3, $4);
    query = 'INSERT INTO users (name, username, email, password) VALUES ($1, $2, $3, $4);'
    
    params = [user.name, user.username, user.email, user.password]

    DatabaseConnection.exec_params(query, params)
    # Returns nothing
  end

  # def update(user)
  # end

  # def delete(user)
  # end
end
