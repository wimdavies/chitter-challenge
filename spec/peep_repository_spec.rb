require 'peep'
require 'peep_repository'

def reset_peeps_table
  seed_sql = File.read('spec/seeds/seeds_peeps.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'chitter_test' })
  connection.exec(seed_sql)
end

describe PeepRepository do
  before(:each) do 
    reset_peeps_table
  end

  after(:each) do 
    reset_peeps_table
  end

  context '#all' do
    it 'returns all peeps' do
      repo = PeepRepository.new

      peeps = repo.all

      expect(peeps.length).to eq 4

      expect(peeps[0].id).to eq '1'
      expect(peeps[0].content).to eq 'test post please ignore'
      expect(peeps[0].time).to eq '2023-05-01 08:00:00'
      expect(peeps[0].user_id ).to eq '1'

      expect(peeps[1].id).to eq '2'
      expect(peeps[1].content).to eq "Wow, can't believe I'm really peeping"
      expect(peeps[1].time).to eq '2023-05-01 08:01:00'
      expect(peeps[1].user_id).to eq '1'

      expect(peeps[2].id).to eq '3'
      expect(peeps[2].content).to eq "@sjmog I'm peeping too, it's great! Everyone should peep."
      expect(peeps[2].time).to eq '2023-05-01 08:02:00'
      expect(peeps[2].user_id).to eq '2'

      expect(peeps[3].id).to eq '4'
      expect(peeps[3].content).to eq "@sjmog @wimdavies omg I'm peeping as well, can't believe this is the future of communication. nothing could possibly go wrong from here onwards"
      expect(peeps[3].time).to eq '2023-05-01 08:05:00'
      expect(peeps[3].user_id).to eq '3'
    end
  end

  context '#find' do
    xit 'returns a peep' do
      repo = PeepRepository.new

      peep = repo.find(1)

      expect(peep.id).to eq '1'
      expect(peep.content).to eq 'test post please ignore'
      expect(peep.time).to eq '2023-05-01 08:00:00'
      expect(peep.user_id).to eq '1'
    end
  end

  context "#create" do
    xit "creates a new peep" do
      repo = PeepRepository.new

      peep = Peep.new

      peep.id = '5'
      peep.content = 'test'
      peep.time = '2023-05-01 08:07:00'
      peep.user_id = '1'

      repo.create(peep)

      last_peep = repo.all.last

      expect(last_peep.id).to eq '5'
      expect(last_peep.content).to eq 'test'
      expect(last_peep.time).to eq '2023-05-01 08:07:00'
      expect(last_peep.user_id).to eq '1'
    end
  end
end
