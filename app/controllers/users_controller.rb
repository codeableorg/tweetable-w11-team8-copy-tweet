class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @user.tweets
    @user.liked_tweets
  end
end
