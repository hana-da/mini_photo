# frozen_string_literal: true

class CreatePhotoPublications < ActiveRecord::Migration[6.0]
  def change
    create_table :photo_publications do |t|
      t.references :photo,     null: false, foreign_key: true
      t.string     :digest,    null: false, index: true
      t.string     :extension, null: false

      t.timestamps
    end
  end
end
