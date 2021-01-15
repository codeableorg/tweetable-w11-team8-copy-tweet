class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all
  end

  def show
    @tweet = Tweet.find(params[:id])
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

    redirect_to tweets_path
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
    params.require(:tweet).permit(:body, :user_id)
  end
end
