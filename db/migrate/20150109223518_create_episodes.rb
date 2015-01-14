class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.integer :episode_id
      t.string :title
      t.string :categories
      t.string :episode_url
      t.string :image_urls
      t.timestamps
    end

    add_index :episodes, :episode_id, unique: true
  end
end
