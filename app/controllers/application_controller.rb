class ApplicationController < Sinatra::Base

configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "surgiapp_secret"
  end

  get '/' do
    if !logged_in?
      erb :index
    else
      redirect to '/home'
    end
    
  end

  get '/sandbox' do
    erb :sandbox
  end

  post '/' do
    if params[:pt_name] == ""
      @name = "Betch! You didn't even enter a name"
    else
      @name = params[:pt_name]
    end
    @result = ["POSITIVE", "NEGATIVE"]
    @greeting = [ "Crack head", "Ass sniffer", "MILF licker", "Bukake nugget"
                ]
    erb :result
  end

  helpers do

    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def valid_login?(str)
      return true if (/^\w*$/.match(str))
      return false
    end

  end

end 