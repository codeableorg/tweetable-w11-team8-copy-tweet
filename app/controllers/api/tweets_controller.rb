class Api::TweetsController < ApiController
  def index
    tweets = Tweet.all
    render json: tweets, only: %i[id body], methods: :replies_count
  end
end