# frozen_string_literal: true

class CreateMyTweetApps < ActiveRecord::Migration[6.0]
  def change
    create_table :my_tweet_apps do |t|
      t.references :user,          null: false, foreign_key: true
      t.string     :access_token,  null: false
      t.string     :token_type,    null: false
      t.integer    :expires_in
      t.string     :refresh_token
      t.string     :scope

      t.timestamps
    end
  end
end
