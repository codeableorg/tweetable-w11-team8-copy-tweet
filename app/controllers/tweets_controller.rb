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
    authorize @tweet
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    authorize @tweet
    if @tweet.save
      redirect_to request.referer
    else
      flash[:notice] = 'Tweet could not be save'
    end
    
  end

  def update
    @tweet = Tweet.find(params[:id])
    @tweet.user = current_user
    if @tweet.update(tweet_params)
      redirect_to request.referer
    else
      flash[:notice] = 'Tweet could not be save'
    end
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    authorize @tweet

    redirect_to request.referer
  end

  private

  def tweet_params
    params.require(:tweet).permit(:body, :user_id, :replied_to_id)
  end
end
