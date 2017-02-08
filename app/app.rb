ENV['RACK_ENV'] ||= 'development'

require 'sinatra'
require 'sinatra/base'
require 'sinatra/flash'
require_relative 'data_mapper_setup'


class Makersbnb < Sinatra::Base
  enable :sessions
  set :session_secret, 'super secret'
  register Sinatra::Flash
  use Rack::MethodOverride
  set :root, File.dirname(__FILE__) + ''
  set :views, Proc.new {File.join(root, "views")}

  get '/' do
    erb :homepage
  end

  get '/users/new' do
  	erb :'users/new'
  end

  post '/users' do
  	user = User.create(name: params[:name], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
  	if user.save
     session[:user_id] = user.id
     redirect to('/')
   else
     #flash.now[:errors] = user.errors.full_messages
     erb :'users/new'
   end
  end

  get '/spaces' do
    erb :'spaces/index'
  end

  get '/spaces/new' do
    erb :'spaces/new'
  end

  post '/spaces' do
    space = Space.new(name: params[:name], description: params[:description], price: params[:price], available_start_date: params[:available_start_date], available_end_date: params[:available_end_date], user_id: session[:user_id])
    if space.save
      redirect '/spaces'
    else
      redirect '/spaces/new'
    end
  end

  get '/sessions/new' do
  	erb :'sessions/new'
  end



  post '/sessions' do
  	user = User.authenticate(params[:email], params[:password])
  	if user
     session[:user_id] = user.id
     redirect to('/spaces')
   else
     #flash.now[:errors] = ['The email or password is incorrect']
    redirect to ('/sessions/new')
   end
  end

  delete '/sessions' do
    session[:user_id] = nil
    redirect '/'
  end

end
