require 'sinatra'
require 'yaml'
require './lib/bookmarker'
require './lib/database'
require './lib/weather'
require './lib/widget'

get '/' do
  haml :index, :layout => :layout
end

get '/slides' do
  haml :slides, :layout => :layout
end

get '/clear' do
  haml :clear, :layout => :layout
end

get '/drop' do
  Database.drop
  redirect '/'
end  

get '/delete' do
  if params[:type]
    case params[:type]
    when 'widget'
      if params[:index]
        Database.delete_widget(params[:index])
        redirect '/'
      end
    when 'bookmarker'
      if params[:w_index] and params[:b_index]
        Database.delete_bookmarker(params[:w_index], params[:b_index])
        redirect '/?edit='+params[:w_index].to_s
      end
    end
  end
end

get '/add' do
  if params[:type]
    case params[:type]
    when 'widget'
      if params[:title] and params[:title] != ""
        widget = Widget.new(params[:title])
        Database.add_widget(widget)
        redirect '/'
      end
    when 'bookmarker'
      if params[:index] and params[:url] and params[:url] != ""
        bookmarker = Bookmarker.new(params[:url], params[:title], params[:note])
        Database.add_bookmarker(params[:index], bookmarker)
        redirect '/?url='+params[:index].to_s
      end
    end
  end
end

get '/move' do 
  Database.move_bookmarker(params[:dir], params[:w_index], params[:b_index])
  redirect '/?edit='+params[:w_index].to_s
end

get '/city' do
  if params[:city]
    Database.change_city(params[:city])
  end
  
  redirect '/'
end
