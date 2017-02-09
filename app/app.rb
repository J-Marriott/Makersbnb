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

   get '/spaces' do
  @spaces = Space.all
  erb :'spaces/index'
  end

  get '/spaces/:id' do
    @space = Space.first(:id => params[:id])
    @user = session[:user_id]
    erb :'requests/new'
  end

  post '/requests' do
    #flash.now[:errors] = ["Check in and check out dates are out of booking date bound"] and replace return 'p'
    return 'p' if params[:check_in_date] < Space.first(:id=>params[:space_id]).available_start_date.to_s || params[:check_out_date] > Space.first(:id=>params[:space_id]).available_end_date.to_s
    request = Request.create(space_id: params[:space_id], check_in_date: params[:check_in_date], check_out_date: params[:check_out_date], request_status: 'pending', user_id: params[:user_id])
    if request.save
      redirect('/')
    else
      #flash.now[:errors] = ['The request was not created, please try again']
      redirect('/spaces/#{params[:space_id]}')
    end

  end


  get '/requests' do
    @userspaces = Space.all(user_id: session[:user_id])
    @pendingrequests = []
    @userspaces.each do |userspace|
      @pendingrequests << userspace.requests
    end
    @requests = Request.all(user_id: session[:user_id])
    @myrequests = []
    @requests.each do |request|
      @myrequests << request
    end
    erb :'requests/index'
  end


  post '/bookings' do
   request = Request.first(id: params[:requestid])
   request.update(request_status: params[:answer])
   redirect '/requests'
  end


end
