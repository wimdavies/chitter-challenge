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
      expect(response.body).to include('<title>Home | Chitter</title>')
      expect(response.body).to include("<h2>What's peeping?</h2>")
      expect(response.body).to include("test post please ignore")
      expect(response.body).to include("Everyone should peep.")
    end
  end

  context "GET /peep" do
    it "returns the form to post a new peep" do
      response = get('/peep')

      expect(response.status).to eq(200)
      expect(response.body).to include('<form action="/peep" method="POST">')
      expect(response.body).to include('<input type="text" name="content">')
    end
  end

  context "POST /peep" do
    it "returns a success page" do
      response = post(
        '/peep',
        content: "omg a new peep",
        user_id: "2"
      )

      expect(response.status).to eq 200
      expect(response.body).to include "You just posted a peep!"
    end

    it "sanitises content by escaping HTML characters" do
      response = post(
        '/peep',
        content: "<script>alert('Hello World!')</script>",
        user_id: "2"
      )

      expect(response.status).to eq 200
      expect(response.body).to include "You just posted a peep!"

      response = get('/')

      expect(response.status).to eq(200)
      expect(response.body).to include("&lt;script&gt;alert(&#39;Hello World!&#39;)&lt;/script&gt;")
    end

    it "responds with 400 status if parameters are invalid" do
      response = post(
        '/peep',
        invalid_param: "omg a new peep",
        another_invalid_param: "2"
      )

      expect(response.status).to eq 400
    end
  end
end
