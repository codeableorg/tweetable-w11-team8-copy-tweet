class LikesController < ApplicationController
  before_action :find_tweet
  before_action :find_like, only: [:destroy]

  def create
    if current_user == nil
      redirect_to new_user_session_path
    else
      if already_liked
        flash[:notice] = "You can't like more than once"
      else
        @tweet.likes.create(user_id: current_user.id)
      end

      if @tweet[:replied_to_id]
        redirect_to tweet_path(@tweet.replied_to)
      else
        redirect_to tweets_path
      end
    end
  end

  def destroy
    if !already_liked
      flash[:notice] = 'Cannot unlike'
    else
      @like.destroy
    end

    if @tweet[:replied_to_id]
      redirect_to tweet_path(@tweet.replied_to)
    else
      redirect_to tweets_path
    end
  end

  private

  def find_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end

  def find_like
    @like = @tweet.likes.find(params[:id])
  end

  def already_liked
    Like.exists?(user_id: current_user.id, tweet_id:
    params[:tweet_id])
  end
end
