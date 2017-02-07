ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'sinatra/flash'
require_relative 'data_mapper_setup'


class Makersbnb < Sinatra::Base
  enable :sessions
  set :session_secret, 'super secret'
  register Sinatra::Flash
  set :views, File.dirname(__FILE__) + '/views'

  get '/' do
    erb :homepage
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end