require 'sinatra'
require 'yaml'
require './lib/bookmarker'
require './lib/database'
require './lib/weather'
require './lib/widget'

get '/' do
  haml :index, :layout => :template
end

get '/delete' do
  if params[:type]
    case params[:type]
    when 'widget'
      if params[:index]
        Database.delete_widget(params[:index])
      end
    when 'bookmarker'
      if params[:w_index] and params[:b_index]
        Database.delete_bookmarker(params[:w_index], params[:b_index])
      end
    end
  end
  
  redirect '/'
end

get '/add' do
  if params[:type]
    case params[:type]
    when 'widget'
      if params[:title] and params[:title] != ""
        widget = Widget.new(params[:title])
        Database.add_widget(widget)
      end
    when 'bookmarker'
      if params[:index] and params[:url] and params[:url] != ""
        bookmarker = Bookmarker.new(params[:url], params[:title], params[:note])
        Database.add_bookmarker(params[:index], bookmarker)
      end
    end
  end
  
  redirect '/'
end

get '/city' do
  if params[:city]
    Database.change_city(params[:city])
  end
  
  redirect '/'
end
