class TweetsController < ApplicationController
  def index
    @tweets = Tweet.select { |tweet| tweet.replied_to_id.nil? }.reverse
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
    @tweet.update(tweet_params)
    if @tweet[:replied_to_id]
      redirect_to tweet_path(@tweet.replied_to)
    else
      redirect_to tweets_path
    end
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    if @tweet[:replied_to_id]
      redirect_to tweet_path(@tweet.replied_to)
    else
      redirect_to tweets_path
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:body, :user_id, :replied_to_id)
  end
end
