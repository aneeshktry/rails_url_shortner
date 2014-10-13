class CreateShortUrls < ActiveRecord::Migration
  def change
    create_table :short_urls do |t|
      t.string :original_url, :limit => 500
      t.string :random_string
      t.string :shortend_url

      t.timestamps
    end
  end
end
