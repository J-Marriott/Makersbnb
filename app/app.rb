ENV['RACK_ENV'] ||= 'development'

require 'sinatra'
require 'sinatra/base'
require 'sinatra/flash'
require_relative 'data_mapper_setup'


class Makersbnb < Sinatra::Base
  enable :sessions
  set :session_secret, 'super secret'
  register Sinatra::Flash
  set :root, File.dirname(__FILE__) + ''
  set :views, Proc.new {File.join(root, "views")}

  get '/' do
    erb :homepage
  end

  get '/users/new' do
  	erb :'users/new'
  end

  post '/users' do
  	User.create(name: params[:name], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
  end

end
