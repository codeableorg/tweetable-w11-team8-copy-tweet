class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all
  end

  def show
    @tweet = Tweet.find(params[:id])
    @reply = Tweet.new
    @reply.replied_to = @tweet
    
  end

  def new
    @user = User.find(params[:user_id])
    @tweet = Tweet.new
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    @tweet.save
    if tweet_params[:replied_to_id]
      redirect_to tweet_path(@tweet.replied_to)
    else
      redirect_to tweets_path
    end
    
  end

  def update
    @tweet = Tweet.find(params[:id])
    @tweet.user = current_user
    if @tweet.update(tweet_params)
      redirect_to tweets_path
    else
      render 'edit'
    end
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy

    redirect_to tweets_path
  end

  private

  def tweet_params
    params.require(:tweet).permit(:body, :user_id, :replied_to_id)
  end
end
