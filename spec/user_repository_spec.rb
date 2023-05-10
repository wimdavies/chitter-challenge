require 'user'
require 'user_repository'

def reset_users_table
  seed_sql = File.read('spec/seeds/seeds_users.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'chitter_test' })
  connection.exec(seed_sql)
end

describe UserRepository do
  before(:each) do 
    reset_users_table
  end

  after(:each) do 
    reset_users_table
  end
  
  context "#all" do
    it "returns all users" do
      repo = UserRepository.new
      
      users = repo.all
      
      expect(users.length).to eq 3
      
      expect(users[0].id).to eq '1'
      expect(users[0].name).to eq 'Sam Morgan'
      expect(users[0].username).to eq 'sjmog'
      expect(users[0].email).to eq 'sam@aol.com'
      expect(users[0].password).to eq 'password123'
      
      expect(users[1].id).to eq '2'
      expect(users[1].name).to eq 'Will Davies'
      expect(users[1].username).to eq 'wimdavies'
      expect(users[1].email).to eq 'will@aol.com'
      expect(users[1].password).to eq 'hunter2'
      
      expect(users[2].id).to eq '3'
      expect(users[2].name).to eq 'Alice Wood'
      expect(users[2].username).to eq 'aliceswood'
      expect(users[2].email).to eq 'alice@aol.com'
      expect(users[2].password).to eq 'alicepass'
    end
  end
  
  context "#find" do
    it "returns the first user" do
      repo = UserRepository.new

      user = repo.find(1)

      expect(user.id).to eq '1'
      expect(user.name).to eq 'Sam Morgan'
      expect(user.username).to eq 'sjmog'
      expect(user.email).to eq 'sam@aol.com'
      expect(user.password).to eq 'password123'
    end

    it "returns the second user" do
      repo = UserRepository.new

      user = repo.find(2)

      expect(user.id).to eq '2'
      expect(user.name).to eq 'Will Davies'
      expect(user.username).to eq 'wimdavies'
      expect(user.email).to eq 'will@aol.com'
      expect(user.password).to eq 'hunter2'
    end
  end

  context "create" do
    it "creates a new user" do
      repo = UserRepository.new

      user = User.new

      user.name = 'Caroline Evans'
      user.username = 'caro'
      user.email = 'caroline@aol.com'
      user.password = 'caropass'

      repo.create(user)

      last_user = repo.all.last

      expect(last_user.name).to eq 'Caroline Evans'
      expect(last_user.username).to eq 'caro'
      expect(last_user.email).to eq 'caroline@aol.com'
      expect(last_user.password).to eq 'caropass'
    end
  end
end
