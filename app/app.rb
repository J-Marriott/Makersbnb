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
    #"Welcome to Makers BnB"
    erb :'homepage'
  end

end
