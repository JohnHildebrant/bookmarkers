require 'sinatra'

get '/' do
  haml :index, :layout => :template
end