# frozen_string_literal: true

class AddColomunBookmarksCountToTweet < ActiveRecord::Migration[7.0]
  def change
    add_column :tweets, :bookmarks_count, :integer, null: false, default: 0
  end
end
