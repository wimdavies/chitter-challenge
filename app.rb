require 'sinatra'
require "sinatra/reloader"
require 'bcrypt'
require 'time'
require 'CGI'
require_relative 'lib/database_connection'
require_relative 'lib/user_repository'
require_relative 'lib/peep_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/user_repository'
    also_reload 'lib/peep_repository'
  end

  get '/' do
    @user_repo = UserRepository.new

    peep_repo = PeepRepository.new
    @sorted_peeps = peep_repo.all.sort_by(&:time).reverse

    return erb(:index)
  end

  get '/peep' do
    return erb(:new_peep)
  end

  post '/peep' do
    if peep_invalid_request_parameters?
      status 400 

      return ""
    end

    content = CGI.escapeHTML(params[:content])
    user_id = params[:user_id]

    new_peep = Peep.new
    new_peep.content = content
    new_peep.time = Time.now
    new_peep.user_id = user_id

    repo = PeepRepository.new
    repo.create(new_peep)

    return erb(:peep_posted)
  end

  get '/signup' do
    return erb(:signup)
  end

  post '/signup' do
    return erb(:signup_success)
  end

  def peep_invalid_request_parameters?
    # Are the params nil?
    return true if params[:content] == nil || params[:user_id] == nil
  
    # Are they empty strings?
    return true if params[:content] == "" || params[:user_id] == ""
  
    return false
  end
end
