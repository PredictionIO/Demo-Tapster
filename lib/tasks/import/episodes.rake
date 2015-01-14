require 'rainbow/ext/string'
require 'csv'
EPISODE_LIST = Rails.root.join('data', 'episode_list.csv')

namespace :import do
  desc 'Import episodes into database'
  task episodes: :environment do
    puts 'Deleting existing episodes!'.color(:yellow)
    Episode.delete_all

    puts 'Starting import...'.color(:green)
    CSV.foreach(EPISODE_LIST, headers: true) do |row|
      e = Episode.new
      e.episode_id = row[0] # episodeId
      e.title = row[1] # episodeTitle
      e.categories = row[3] # episodeCategories
      e.episode_url = row[5] # episodeUrl
      e.image_urls = row[6] # episodeImageUrls - semicolan seperated!
      if e.save
        puts "Episode #{e.id} saved!".color(:green)
      else
        puts "Episode failed to save! #{e.errors.full_messages.join('; ')}".color(:red)
      end
    end
  end
end
