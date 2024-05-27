# frozen_string_literal: true

class CreateFollows < ActiveRecord::Migration[7.0]
  def change
    create_table :follows do |t|
      t.references :following_user, null: false, foreign_key: { to_table: :users }
      t.references :followed_user, null: false, foreign_key: { to_table: :users }
      t.timestamps
    end

    add_index :follows, %i[following_user_id followed_user_id], unique: true
  end
end
