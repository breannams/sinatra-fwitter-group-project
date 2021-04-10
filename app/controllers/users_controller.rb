class UsersController < ApplicationController

    get '/signup' do
        if !logged_in?
            erb :'/users/signup'
            
        else
            redirect to '/tweets'
        end

    end
    
    post '/signup'do
    if !params[:username] == "" || !params[:email] == "" || !params[:password] == ""
       
    @user = User.new(email: params[:email], username: params[:username], password: params[:password])
    @user.save
    binding.pry
    if @user.save
        session[:user_id] = @user.id
        redirect to '/tweets'
    else
        redirect to '/signup'
     
    end
    end
    end

    get '/login' do
        if !logged_in?
            erb :'/users/login'
        else
            redirect to '/tweets'
        end
    end

    post '/login' do
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
          redirect to '/tweets'
        else
            redirect to '/signup'
        end
        
    end

    get '/logout' do
        session.clear
        
        if logged_in?
            redirect to '/tweets'
        else
            redirect "/login"
        end
      end
    
    get "/users/:slug" do

        @user = User.find_by_slug(params[:slug])
    
        erb :'/users/show'
    
      end

end
