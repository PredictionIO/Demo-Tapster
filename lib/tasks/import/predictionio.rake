# This script will takes about 4 minutes to run!

require 'rainbow/ext/string'
require 'csv'
USER_LIST = Rails.root.join('data', 'user_list.csv')
THREADS = 50
namespace :import do
  desc 'Send the data to PredictionIO'
  task predictionio: :environment do
    line_count = CSV.read(USER_LIST).length

    puts 'Starting import...'.color(:blue)

    client = PredictionIO::EventClient.new(ENV['PIO_ACCESS_KEY'], ENV['PIO_EVENT_SERVER_URL'], THREADS)

    # Search CSV file for episode and user IDs.
    user_ids = []
    episode_ids = []
    CSV.foreach(USER_LIST, headers: true) do |row|
      user_id = row[0] # userId
      episode_id = row[1] # episodeId
      puts "Reading line #{$INPUT_LINE_NUMBER} of #{line_count}."
      user_ids << user_id
      episode_ids << episode_id
    end

    # Calculate unique values.
    user_ids.uniq!
    user_count = user_ids.count
    episode_ids.uniq!
    episode_count = episode_ids.count

    puts "Found #{user_count} unique user IDs!".color(:blue)
    puts "Found #{episode_count} unique episode IDs!".color(:blue)

    puts 'Starting users...'.color(:blue)

    user_ids.each_with_index do |id, i|
      # Send unique user IDs to PredictionIO.
      client.aset_user(id)
      puts "Sent user ID #{id} to PredictionIO. Action #{i + 1} of #{user_count}"
    end

    puts 'Done with users!'.color(:green)

    puts 'Starting episodes...'.color(:blue)

    episode_ids.each_with_index do |id, i|
      # Load episode from database - we will need this to include the categories!
      episode = Episode.where(episode_id: id).take

      if episode
        # Send unique episode IDs to PredictionIO.
        client.create_event(
          '$set',
          'item',
          id,
          properties: { categories: episode.categories }
        )
        puts "Sent episode ID #{id} to PredictionIO. Action #{i + 1} of #{episode_count}"
      else
        puts "Episode ID #{id} not found in database! Skipping!".color(:red)
      end
    end

    puts 'Done with episodes!'.color(:green)

    puts 'Starting views...'.color(:blue)
    CSV.foreach(USER_LIST, headers: true) do |row|
      user_id = row[0]
      episode_id = row[1]
      # Send view to PredictionIO.
      client.acreate_event(
        'view',
        'user',
        user_id,
        { 'targetEntityType' => 'item', 'targetEntityId' => episode_id }
      )
      puts "Sent user ID #{user_id} viewed episode ID #{episode_id} to PredictionIO. Action #{$INPUT_LINE_NUMBER} of #{line_count}."
    end

    puts 'Done with views!'.color(:green)

    puts 'All Done!'.color(:green)
  end
end
