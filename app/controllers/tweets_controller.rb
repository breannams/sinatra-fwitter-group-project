class TweetsController < ApplicationController
    get '/tweets' do
        if logged_in? && current_user
        @tweets = Tweet.all
        erb :'/tweets/tweets'
        else
            redirect to '/login'
        end
    end

        get '/tweets/new' do
            if logged_in? && current_user
                erb :'tweets/create_tweet'
            else
                redirect to '/login'
            end
        end

        post '/tweets' do
        
            @tweet = Tweet.create(content: params[:content], user: current_user)
            if !params[:content].empty?
                redirect to "/tweets"
            else 
                redirect to "/tweets/new"
            end
        end

        get '/tweets/:id' do
            if logged_in?
                @tweet = Tweet.find_by_id(params[:id])
                erb :'/tweets/show_tweet'
            else 
                redirect to '/login'
            end
        end


        get '/tweets/:id/edit' do
            @tweet = Twett.find_by_id(params[:id])
            if @tweet.user == current_user
                erb :'tweets/edit_tweet'
            else
                redirect to '/login'
            end
        end


       
        patch '/tweets/:id' do
            @tweet = Tweet.find(params[:id])
            if @tweet && @tweet.update(params[:tweets])
                redirect to "/tweets/#{@tweet.id}"
            else
                redirect to "/tweets/#{@tweet.id}/edit"
            end
        end

        delete '/tweets/:id/delete' do
            @tweet = current_user.tweets.find_by(id: params[:id])
            if @tweet && @tweet.destroy
              redirect to "/tweets"
            else
              redirect to "/tweets/#{tweet.id}"
            end
        end


end
