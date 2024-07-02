# frozen_string_literal: true

class CreateTweets < ActiveRecord::Migration[7.0]
  def change
    create_table :tweets do |t|
      t.references :user, null: false, foreign_key: true
      t.text :content, null: false
      t.integer :likes_count, null: false, default: 0
      t.integer :retweets_count, null: false, default: 0
      t.timestamps
    end
  end
end
