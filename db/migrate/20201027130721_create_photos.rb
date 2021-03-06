# frozen_string_literal: true

class CreatePhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :photos do |t|
      t.references :user,  null: false, foreign_key: true
      t.string     :title, null: false

      t.timestamps
    end
  end
end
