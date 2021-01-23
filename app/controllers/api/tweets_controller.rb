class Api::TweetsController < ApiController
  before_action :set_tweet, only: %i[show update destroy]
  
  def index
    tweets = Tweet.all
    render json: tweets, only: %i[id body], methods: :replies_count
  end

  def show
    render json: @tweet, only: %i[id body], include: {
      replies: { only: %i[id body] }
    }
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    authorize @tweet
    if @tweet.save
      render json: @tweet, status: :created
    else
      render json: @tweet.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize @tweet
    if @tweet.update(tweet_params)
      render json: @tweet
    else
      render json: @tweet.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @tweet
    @tweet.destroy
    head :no_content
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:body)
  end
end
