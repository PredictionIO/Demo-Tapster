class EpisodesController < ApplicationController
  def random
    @episode = random_episode

    render json: @episode
  end

  def query
    # Create PredictionIO client.
    client = PredictionIO::EngineClient.new(ENV['PIO_ENGINE_URL'])

    # Get posted likes and dislikes.
    likes = ActiveSupport::JSON.decode(params[:likes])
    dislikes = ActiveSupport::JSON.decode(params[:dislikes])

    if likes.empty?
      # We can't query PredictionIO with no likes so
      # we will return a random comic instead.
      @episode = random_episode

      render json: @episode
      return
    end

    # Query PredictionIO.
    # Here we black list the disliked items so they are not shown again!
    response = client.send_query(items: likes, blackList: dislikes,  num: 1)

    # With a real application you would want to do some
    # better sanity checking of the response here!

    # Get ID of response.
    id = response['itemScores'][0]['item']

    # Find episode in database.
    @episode = Episode.where(episode_id: id).take

    render json: @episode
  end

  private

  def random_episode
    # PostgreSQL
    # Comment this line out of you are using MySQL!
    Episode.order('RANDOM()').first

    # MySQL
    # Uncomment this link if you are using MySQL
    # Episode.order('RAND()').first
  end
end
