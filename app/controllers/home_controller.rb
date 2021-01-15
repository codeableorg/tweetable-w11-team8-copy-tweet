class HomeController < ApplicationController
  def index
    @tweets = Tweet.all.reverse
  end
end
