# users Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

```
Table: users

Columns:
id | name | username | email | password
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- (file: spec/seeds_users.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)
-- CASCADE ensures deletions here also delete dependent records on the 'peeps' table

TRUNCATE TABLE users RESTART IDENTITY CASCADE; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO users (name, username, email, password) VALUES ('Sam Morgan', 'sjmog', 'sam@aol.com', 'password123');
INSERT INTO users (name, username, email, password) VALUES ('Will Davies', 'wimdavies', 'will@aol.com', 'hunter2');
INSERT INTO users (name, username, email, password) VALUES ('Alice Wood', 'aliceswood', 'alice@aol.com', 'alicepass');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_users.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# Table name: users

# Model class
# (in lib/user.rb)
class User
end

# Repository class
# (in lib/user_repository.rb)
class UserRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# Table name: users

# Model class
# (in lib/user.rb)

class User

  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :username, :email, :password
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# user = User.new
# user.name = 'Jo'
# user.name
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# Table name: users

# Repository class
# (in lib/user_repository.rb)

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
    # INSERT INTO users (name, username, email, password) VALUES ($1, $2, $3, $4);

    # Returns nothing
  end

  # def update(user)
  # end

  # def delete(user)
  # end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# 1
# Get all users
repo = UserRepository.new

users = repo.all

users.length # =>  3

users[0].id # =>  '1'
users[0].name # =>  'Sam Morgan'
users[0].username # =>  'sjmog'
users[0].email # =>  'sam@aol.com'
users[0].password # =>  'password123'

users[1].id # =>  '2'
users[1].name # =>  'Will Davies'
users[1].username # =>  'wimdavies'
users[1].email # =>  'will@aol.com'
users[1].password # =>  'hunter2'

users[2].id # =>  '3'
users[2].name # =>  'Alice Wood'
users[2].username # =>  'aliceswood'
users[2].email # =>  'alice@aol.com'
users[2].password # =>  'alicepass'

# 2
# Get the first user
repo = UserRepository.new

user = repo.find(1)

user.id # =>  '1'
user.name # =>  'Sam Morgan'
user.username # =>  'sjmog'
user.email # =>  'sam@aol.com'
user.password # =>  'password123'

# 3
# Gets the second user
repo = UserRepository.new

user = repo.find(2)

user.id # =>  '2'
user.name # =>  'Will Davies'
user.username # =>  'wimdavies'
user.email # =>  'will@aol.com'
user.password # =>  'hunter2'

# 4
# creates a new user
repo = UserRepository.new

user = User.new

user.name = 'Caroline Evans'
user.username = 'caro'
user.email = 'caroline@aol.com'
user.password = 'caropass'

repo.create(user) # => nil

last_user = repo.all.last

last_user.name # => 'Caroline Evans'
last_user.username # => 'caro'
last_user.email # => 'caroline@aol.com'
last_user.password # => 'caropass'

```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# file: spec/user_repository_spec.rb

def reset_users_table
  seed_sql = File.read('spec/seeds_users.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'chitter_test' })
  connection.exec(seed_sql)
end

describe UserRepository do
  before(:each) do 
    reset_users_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._