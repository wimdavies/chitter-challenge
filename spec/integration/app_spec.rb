require "spec_helper"
require "rack/test"
require_relative '../../app'

def reset_users_table
  seed_sql = File.read('spec/seeds/seeds_users.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'chitter_test' })
  connection.exec(seed_sql)
end

def reset_peeps_table
  seed_sql = File.read('spec/seeds/seeds_peeps.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'chitter_test' })
  connection.exec(seed_sql)
end

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  before(:each) do 
    reset_users_table
    reset_peeps_table
  end

  after(:each) do 
    reset_users_table
    reset_peeps_table
  end

  context "GET /" do
    it 'returns list of all peeps with 200 OK' do
      response = get('/')

      expect(response.status).to eq(200)
      expect(response.body).to include('<title>Chitter</title>')
      expect(response.body).to include("<h2>What's peeping?</h2>")
      expect(response.body).to include("test post please ignore")
      expect(response.body).to include("Everyone should peep.")
    end
  end
end