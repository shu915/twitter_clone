# frozen_string_literal: true

class CreateNotices < ActiveRecord::Migration[7.0]
  def change
    create_table :notices do |t|
      t.references :sender, null: false, foreign_key: { to_table: :users }
      t.references :receiver, null: false, foreign_key: { to_table: :users }
      t.integer :notice_type, null: false
      t.references :like, foreign_key: true, null: true
      t.references :retweet, foreign_key: true, null: true
      t.references :reply, foreign_key: { to_table: :tweets }, null: true
      t.boolean :read, null: false, default: false
      t.timestamps
    end
  end
end
